import 'dart:convert';
import 'package:dio/dio.dart';

/// A failure with a user-facing message, optional HTTP status code,
/// API error code, and error details (e.g. Zod validation errors).
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? code;
  final dynamic details;

  ApiException(
    this.message, {
    this.statusCode,
    this.code,
    this.details,
  });

  bool get isUnauthorized => statusCode == 401;
  bool get isForbidden => statusCode == 403;
  bool get isConflict => statusCode == 409;
  bool get isRateLimited => statusCode == 429;

  /// Creates a clean [ApiException] from a [DioException], extracting the exact
  /// server-provided error message if present, or a user-friendly default.
  /// Never leaks raw technical Dio stack messages to the user.
  factory ApiException.fromDio(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;

    String? extractedMessage;
    String? extractedCode;
    dynamic extractedDetails;

    // 1. Try extracting exact server message from response data
    if (response?.data != null) {
      dynamic data = response!.data;

      // Handle raw JSON string if not already decoded by Dio
      if (data is String && data.trim().startsWith('{')) {
        try {
          data = jsonDecode(data);
        } catch (_) {}
      }

      if (data is Map) {
        final errorPayload = data['error'];

        if (errorPayload is Map) {
          if (errorPayload['message'] != null) {
            extractedMessage = errorPayload['message'].toString();
          }
          if (errorPayload['code'] != null) {
            extractedCode = errorPayload['code'].toString();
          }
          if (errorPayload['details'] != null) {
            extractedDetails = errorPayload['details'];
          }
        } else if (errorPayload is String && errorPayload.trim().isNotEmpty) {
          extractedMessage = errorPayload.trim();
        }

        if (extractedMessage == null && data['message'] != null) {
          extractedMessage = data['message'].toString();
        }

        if (extractedCode == null && data['code'] != null) {
          extractedCode = data['code'].toString();
        }
      } else if (data is String && data.trim().isNotEmpty && !data.contains('<html')) {
        extractedMessage = data.trim();
      }
    }

    // 2. Fall back to user-friendly message based on status code or DioExceptionType
    final finalMessage = extractedMessage?.isNotEmpty == true
        ? extractedMessage!
        : _fallbackMessage(error, statusCode);

    return ApiException(
      finalMessage,
      statusCode: statusCode,
      code: extractedCode,
      details: extractedDetails,
    );
  }

  static String _fallbackMessage(DioException error, int? statusCode) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond. Please try again.';
      case DioExceptionType.connectionError:
        return 'Cannot connect to server. Please check your internet connection.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      default:
        break;
    }       

    switch (statusCode) {
      case 400:
        return 'Invalid request. Please check your input.';
      case 401:
        return 'Invalid credentials or session expired.';
      case 403:
        return 'You do not have permission to perform this action.';
      case 404:
        return 'The requested resource was not found.';
      case 409:
        return 'A conflict occurred. Please try again.';
      case 429:
        return 'Too many requests. Please wait a moment and try again.';
      default:
        if (statusCode != null && statusCode >= 500) {
          return 'The server encountered an error. Please try again later.';
        }
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  String toString() => message;
}
