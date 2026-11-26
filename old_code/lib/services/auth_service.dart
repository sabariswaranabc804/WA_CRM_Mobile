import '../core/api_client.dart';
import '../core/formatters.dart';
import '../models/session.dart';

/// Login, session restore and logout.
///
/// Registration is intentionally absent: tenants are onboarded on the web
/// (`POST /auth/register`), and this app is agent-facing only.
class AuthService {
  final ApiClient api;

  AuthService(this.api);

  Future<AuthSession> login({
    required String workspace,
    required String email,
    required String password,
  }) async {
    final data = await api.post('/auth/login', body: {
      'email': email.trim(),
      'password': password,
      // The server slugifies too, but sending the slug keeps what the user
      // typed ("Test Corp 1") and what we store in sync.
      'tenantSlug': slugify(workspace),
    });

    if (data is! Map) {
      throw ApiException('Unexpected login response from the server.');
    }
    return AuthSession.fromJson(Map<String, dynamic>.from(data));
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
