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

  @override
  String toString() => message;
}
