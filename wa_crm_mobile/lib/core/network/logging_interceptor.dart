import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Interceptor that logs every HTTP request, query parameters, request body,
/// response payload, latency, and failure details.
class LoggingInterceptor extends Interceptor {
  final bool enabled;

  LoggingInterceptor({this.enabled = kDebugMode});

  static const String _startTimeKey = '_request_start_time';
  static const JsonEncoder _prettyEncoder = JsonEncoder.withIndent('  ');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!enabled) return handler.next(options);

    options.extra[_startTimeKey] = DateTime.now().millisecondsSinceEpoch;

    final buffer = StringBuffer();
    buffer.writeln('🚀 [API REQUEST] ${options.method} ${options.uri}');

    if (options.queryParameters.isNotEmpty) {
      buffer.writeln('📋 Query Parameters:');
      buffer.writeln(_formatPayload(options.queryParameters));
    }

    if (options.headers.isNotEmpty) {
      final sanitizedHeaders = Map<String, dynamic>.from(options.headers);
      if (sanitizedHeaders.containsKey('Authorization')) {
        final authHeader = sanitizedHeaders['Authorization'].toString();
        if (authHeader.startsWith('Bearer ') && authHeader.length > 15) {
          sanitizedHeaders['Authorization'] =
              '${authHeader.substring(0, 12)}...[HIDDEN]';
        }
      }
      buffer.writeln('🏷️ Headers:');
      buffer.writeln(_formatPayload(sanitizedHeaders));
    }

    if (options.data != null) {
      buffer.writeln('📦 Request Body:');
      buffer.writeln(_formatPayload(options.data));
    }

    developer.log(
      buffer.toString().trimRight(),
      name: 'API_REQUEST',
    );

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!enabled) return handler.next(response);

    final duration = _calculateDuration(response.requestOptions);
    final buffer = StringBuffer();

    buffer.writeln(
      '✅ [API RESPONSE ${response.statusCode}] '
      '${response.requestOptions.method} ${response.requestOptions.uri} '
      '(${duration}ms)',
    );

    if (response.data != null) {
      buffer.writeln('📥 Response Payload:');
      buffer.writeln(_formatPayload(response.data));
    }

    developer.log(
      buffer.toString().trimRight(),
      name: 'API_RESPONSE',
    );

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!enabled) return handler.next(err);

    final duration = _calculateDuration(err.requestOptions);
    final statusCode = err.response?.statusCode ?? 'NO_STATUS';
    final buffer = StringBuffer();

    buffer.writeln(
      '❌ [API ERROR $statusCode] '
      '${err.requestOptions.method} ${err.requestOptions.uri} '
      '(${duration}ms)',
    );
    buffer.writeln('⚠️ Error Type: ${err.type}');
    buffer.writeln('💬 Error Message: ${err.message}');

    if (err.response?.data != null) {
      buffer.writeln('📥 Error Response Data:');
      buffer.writeln(_formatPayload(err.response?.data));
    }

    developer.log(
      buffer.toString().trimRight(),
      name: 'API_ERROR',
      error: err.error,
    );

    handler.next(err);
  }

  int _calculateDuration(RequestOptions options) {
    final startTime = options.extra[_startTimeKey] as int?;
    if (startTime == null) return 0;
    return DateTime.now().millisecondsSinceEpoch - startTime;
  }

  String _formatPayload(dynamic payload) {
    try {
      if (payload is Map || payload is List) {
        return _prettyEncoder.convert(payload);
      }
      if (payload is FormData) {
        final fields = payload.fields.map((e) => '${e.key}: ${e.value}').toList();
        final files = payload.files.map((e) => '${e.key}: ${e.value.filename}').toList();
        return 'FormData(fields: $fields, files: $files)';
      }
      return payload.toString();
    } catch (_) {
      return payload.toString();
    }
  }
}
