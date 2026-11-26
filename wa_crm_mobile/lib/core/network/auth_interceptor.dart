
import 'dart:async';

import 'package:dio/dio.dart';

import '../storage/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final Dio refreshDio;
  final TokenStorage tokenStorage;
  final String refreshUrl;
  final Future<void> Function()? onSessionExpired;

  Future<String>? _refreshFuture;

  AuthInterceptor({
    required this.dio,
    required this.refreshDio,
    required this.tokenStorage,
    required this.refreshUrl,
    this.onSessionExpired,
  });

  // 1. Automatically attach Access Token
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final requiresAuth =
          options.extra['requiresAuth'] != false;

      if (requiresAuth) {
        final token = await tokenStorage.getAccessToken();

        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      }

      handler.next(options);
    } catch (e) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: e,
        ),
      );
    }
  }

  // 2. Handle expired Access Token
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final request = err.requestOptions;

    final requiresAuth =
        request.extra['requiresAuth'] != false;

    final alreadyRetried =
        request.extra['retried'] == true;

    if (err.response?.statusCode != 401 ||
        !requiresAuth ||
        alreadyRetried) {
      return handler.next(err);
    }

    try {
      final newToken = await _refreshAccessToken();

      request.headers['Authorization'] = 'Bearer $newToken';
      request.extra['retried'] = true;

      final response = await dio.fetch(request);

      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    } catch (_) {
      return handler.next(err);
    }
  }

  // 3. Single refresh request for concurrent 401 errors
  Future<String> _refreshAccessToken() {
    final existing = _refreshFuture;

    if (existing != null) {
      return existing;
    }

    final future = _performRefresh();

    _refreshFuture = future;

    return future.whenComplete(() {
      _refreshFuture = null;
    });
  }

  // 4. Call Refresh API
  Future<String> _performRefresh() async {
    final refreshToken =
        await tokenStorage.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      await _expireSession();
      throw Exception('Refresh token unavailable');
    }

    try {
      final response = await refreshDio.post(
        refreshUrl,
        data: {
          'refreshToken': refreshToken,
        },
      );

      final data = response.data as Map<String, dynamic>;

      // Change these keys according to your backend response.
      final newAccessToken = data['accessToken'] as String;

      final newRefreshToken =
          data['refreshToken'] as String? ?? refreshToken;

      if (newAccessToken.isEmpty) {
        throw const FormatException('Empty access token');
      }

      // Save both tokens, including rotated refresh token.
      await tokenStorage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      return newAccessToken;
    } on DioException catch (e) {
      // Logout only when refresh token is rejected.
      if (e.response?.statusCode == 401 ||
          e.response?.statusCode == 403) {
        await _expireSession();
      }

      rethrow;
    } on FormatException {
      rethrow;
    }
  }

  Future<void> _expireSession() async {
    await tokenStorage.clearTokens();
    await onSessionExpired?.call();
  }
}
