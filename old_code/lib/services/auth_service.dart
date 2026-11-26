
import 'dart:developer';

import 'package:dio/dio.dart';

import '../core/api_client.dart';
import '../core/formatters.dart';
import '../models/session.dart';

/// Login, session restore and logout.
///
/// Registration is intentionally absent: tenants are onboarded on the web
/// (`POST /auth/register`), and this app is agent-facing only.
class AuthService {
  final ApiClient api;
final dio = Dio();
  AuthService(this.api);

 
 


Future<AuthSession> login({
  required String workspace,
  required String email,
  required String password,
}) async {
  try {
    log("email: $email, password: $password, workspace: $workspace");
    final response = await dio.post(
      'https://assistant-served-million-onto.trycloudflare.com/api/v1/auth/login',
      data: {
        'email': email.trim(),
        'password': password,
        'tenantSlug': slugify(workspace),
      },
    );

    log(
      'Response: ${response.data}',
      name: 'AUTH_SERVICE',
    );

    final responseData = response.data;

    if (responseData is! Map) {
      throw ApiException('Unexpected login response.');
    }

    return AuthSession.fromJson(
      Map<String, dynamic>.from(responseData),
    );
  } on DioException catch (e) {
    log(
      'Request URL: ${e.requestOptions.uri}',
      name: 'AUTH_SERVICE',
    );

    log(
      'Status Code: ${e.response?.statusCode}',
      name: 'AUTH_SERVICE',
    );

   log(
      'Error Response: ${e.response?.data}',
      name: 'AUTH_SERVICE',
    );

    rethrow;
  }
}

  /// Confirms a stored token is still good and returns the current identity.
  Future<({AuthUser user, Tenant? tenant})> me() async {
    final data = await api.get('/auth/me');
    if (data is! Map) {
      throw ApiException('Unexpected session response from the server.');
    }
    final map = Map<String, dynamic>.from(data);
    final tenantJson = map['tenant'];
    return (
      user: AuthUser.fromJson(Map<String, dynamic>.from(map['user'] as Map)),
      tenant: tenantJson is Map
          ? Tenant.fromJson(Map<String, dynamic>.from(tenantJson))
          : null,
    );
  }

  /// Best-effort server-side session revocation.
  Future<void> logout(String? refreshToken) async {
    try {
      await api.post('/auth/logout', body: {'refreshToken': refreshToken});
    } on ApiException {
      // Local tokens are cleared regardless — a failed revoke must not trap
      // the user in a session they asked to end.
    }
  }
}
