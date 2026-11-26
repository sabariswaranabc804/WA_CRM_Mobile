import '../core/json_utils.dart';

/// The signed-in agent.
class AuthUser {
  final int id;
  final int tenantId;
  final String name;
  final String email;
  final List<String> roles;
  final List<String> permissions;

  const AuthUser({
    required this.id,
    required this.tenantId,
    required this.name,
    required this.email,
    required this.roles,
    required this.permissions,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: asInt(json['id']),
      tenantId: asInt(json['tenant_id']),
      name: asString(json['name'], 'Agent'),
      email: asString(json['email']),
      roles: asStringList(json['roles']),
      permissions: asStringList(json['permissions']),
    );
  }

  bool can(String permission) =>
      permissions.contains(permission) || permissions.contains('*');
}

/// The workspace the agent belongs to.
class Tenant {
  final int id;
  final String name;
  final String slug;
  final String? status;

  const Tenant({
    required this.id,
    required this.name,
    required this.slug,
    this.status,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      id: asInt(json['id']),
      name: asString(json['name'], 'Workspace'),
      slug: asString(json['slug']),
      status: asStringOrNull(json['status']),
    );
  }
}

/// What `POST /auth/login` returns.
class AuthSession {
  final AuthUser user;
  final Tenant? tenant;
  final String accessToken;
  final String refreshToken;

  const AuthSession({
    required this.user,
    required this.tenant,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    final tenantJson = json['tenant'];
    return AuthSession(
      user: AuthUser.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
      tenant: tenantJson is Map
          ? Tenant.fromJson(Map<String, dynamic>.from(tenantJson))
          : null,
      accessToken: asString(json['accessToken']),
      refreshToken: asString(json['refreshToken']),
    );
  }
}
