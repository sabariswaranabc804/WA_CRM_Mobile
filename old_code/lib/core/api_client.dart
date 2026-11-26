import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';

import 'config.dart';
import 'token_storage.dart';

/// A failure with a message already fit to show a user.
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  bool get isUnauthorized => statusCode == 401;

  @override
  String toString() => message;
}

/// Dio wrapper that attaches the bearer token, refreshes it once on a 401 and
/// unwraps the API's `{ success, data }` envelope.
///
/// CSRF headers are deliberately not sent: `csrfProtection` runs in app.js
/// before any route-level `authenticate`, so `req.user` is unset there and the
/// check short-circuits for bearer-token callers. It only guards cookie
/// sessions, which this client does not use.
class ApiClient {
  final TokenStorage storage;
  late final Dio _dio;

  /// Invoked when refreshing fails and the user must log in again.
  void Function()? onAuthFailure;

  /// De-duplicates concurrent refreshes so a burst of 401s triggers one call.
  Future<bool>? _refreshInFlight;

  ApiClient(this.storage) {
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      // Handle every status ourselves so error bodies survive to _unwrap.
      validateStatus: (_) => true,
    ));
  }

  /// Picks up a server URL changed at runtime.
  void syncBaseUrl() => _dio.options.baseUrl = AppConfig.apiBaseUrl;

  // ── Verbs ────────────────────────────────────────────────────────────

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) =>
      _send(() => _dio.get(path, queryParameters: _clean(query)));

  Future<dynamic> post(String path, {Object? body}) =>
      _send(() => _dio.post(path, data: body));

  Future<dynamic> patch(String path, {Object? body}) =>
      _send(() => _dio.patch(path, data: body));

  Future<dynamic> delete(String path) => _send(() => _dio.delete(path));

  /// Like [get] but returns the whole envelope, for endpoints whose pagination
  /// lives beside `data` rather than inside it.
  Future<Map<String, dynamic>> getEnvelope(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    final response = await _authorized(
      () => _dio.get(path, queryParameters: _clean(query)),
    );
    _throwIfError(response);
    final body = response.data;
    return body is Map<String, dynamic> ? body : <String, dynamic>{'data': body};
  }

  // ── Plumbing ─────────────────────────────────────────────────────────

  Map<String, dynamic>? _clean(Map<String, dynamic>? query) {
    if (query == null) return null;
    final entries = query.entries.where((e) {
      final v = e.value;
      return v != null && !(v is String && v.isEmpty);
    });
    return Map.fromEntries(entries);
  }

  Future<dynamic> _send(Future<Response> Function() request) async {
    debugPrint('jwefwef: $request');
    final response = await _authorized(request);
    _throwIfError(response);
    return _unwrap(response.data);
  }

  /// Runs [request] with the stored token, retrying once after a refresh.
  Future<Response> _authorized(Future<Response> Function() request) async {
    _dio.options.headers['Authorization'] = await _bearer();

    late Response response;
    try {
      response = await request();
    } on DioException catch (e) {
      throw _networkFailure(e);
    }

    if (response.statusCode != 401) return response;

    final refreshed = await _refreshOnce();
    if (!refreshed) {
      onAuthFailure?.call();
      throw ApiException('Your session has expired. Please log in again.',
          statusCode: 401);
    }

    _dio.options.headers['Authorization'] = await _bearer();
    try {
      return await request();
    } on DioException catch (e) {
      throw _networkFailure(e);
    }
  }

  Future<String?> _bearer() async {
    final token = await storage.readAccessToken();
    return token == null ? null : 'Bearer $token';
  }

  Future<bool> _refreshOnce() {
    return _refreshInFlight ??= _performRefresh().whenComplete(() {
      _refreshInFlight = null;
    });
  }

  Future<bool> _performRefresh() async {
    final refreshToken = await storage.readRefreshToken();
    if (refreshToken == null) return false;

    try {
      // A bare Dio: the interceptor-free path avoids recursing into _authorized.
      final refreshDio = Dio(BaseOptions(
        baseUrl: _dio.options.baseUrl,
        validateStatus: (_) => true,
      ));
      final response = await refreshDio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      final status = response.statusCode ?? 0;
      if (status < 200 || status >= 300) return false;

      final data = _unwrap(response.data);
      if (data is! Map) return false;

      final newAccess = data['accessToken'] as String?;
      final newRefresh = data['refreshToken'] as String?;
      if (newAccess == null) return false;

      if (newRefresh != null) {
        await storage.saveTokens(accessToken: newAccess, refreshToken: newRefresh);
      } else {
        await storage.saveAccessToken(newAccess);
      }
      return true;
    } on DioException {
      return false;
    }
  }

  void _throwIfError(Response response) {
    final status = response.statusCode ?? 0;
    if (status >= 200 && status < 300) return;
    throw ApiException(_messageFrom(response.data, status), statusCode: status);
  }

  /// The API answers `{ success, data }` on success and
  /// `{ success: false, error: { code, message } }` (or `{ message }`) on failure.
  String _messageFrom(dynamic body, int status) {
    if (body is Map) {
      final error = body['error'];
      if (error is Map && error['message'] is String) {
        return error['message'] as String;
      }
      if (body['message'] is String) return body['message'] as String;
    }
    if (status == 401) return 'Your session has expired. Please log in again.';
    if (status == 403) return 'You do not have permission to do that.';
    if (status == 404) return 'Not found.';
    if (status >= 500) return 'The server ran into a problem. Please try again.';
    return 'Request failed ($status).';
  }

  dynamic _unwrap(dynamic body) {
    if (body is Map && body.containsKey('data')) return body['data'];
    return body;
  }

  ApiException _networkFailure(DioException e) {
    final base = _dio.options.baseUrl;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('The server took too long to respond.');
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        // On web the browser hides the real reason: a CORS rejection and a
        // dead server both surface as an opaque failure, so name both.
        if (kIsWeb) {
          return ApiException(
            'The browser could not complete the request to $base.\n\n'
            'Either the server is not running, or this page\'s origin is not '
            'listed in the server\'s ALLOWED_ORIGINS, which makes the browser '
            'block the response.',
          );
        }
        return ApiException(
          'Cannot reach the server at $base.\n'
          'Check that it is running and that the URL is correct.',
        );
      default:
        return ApiException(e.message ?? 'Network error.');
    }
  }
}
