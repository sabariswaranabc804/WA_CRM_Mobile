// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => _AuthModel(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: AuthModelData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthModelToJson(_AuthModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_AuthModelData _$AuthModelDataFromJson(Map<String, dynamic> json) =>
    _AuthModelData(
      user: AuthModelDataUser.fromJson(json['user'] as Map<String, dynamic>),
      tenant: json['tenant'] == null
          ? null
          : AuthModelDataTenant.fromJson(
              json['tenant'] as Map<String, dynamic>,
            ),
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      sessionId: (json['sessionId'] as num).toInt(),
    );

Map<String, dynamic> _$AuthModelDataToJson(_AuthModelData instance) =>
    <String, dynamic>{
      'user': instance.user,
      'tenant': instance.tenant,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'sessionId': instance.sessionId,
    };

_AuthModelDataUser _$AuthModelDataUserFromJson(Map<String, dynamic> json) =>
    _AuthModelDataUser(
      id: json['id'] as String,
      tenantId: json['tenant_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'],
      status: json['status'] as String,
      googleId: json['google_id'],
      authProvider: json['auth_provider'] as String,
      lastLoginAt: json['last_login_at'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      roleIds:
          (json['role_ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      permissions:
          (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      rolePermissions:
          (json['role_permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      permissionOverrides:
          json['permission_overrides'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$AuthModelDataUserToJson(_AuthModelDataUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenant_id': instance.tenantId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'status': instance.status,
      'google_id': instance.googleId,
      'auth_provider': instance.authProvider,
      'last_login_at': instance.lastLoginAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'roles': instance.roles,
      'role_ids': instance.roleIds,
      'permissions': instance.permissions,
      'role_permissions': instance.rolePermissions,
      'permission_overrides': instance.permissionOverrides,
    };

_AuthModelDataTenant _$AuthModelDataTenantFromJson(Map<String, dynamic> json) =>
    _AuthModelDataTenant(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      status: json['status'] as String,
      timezone: json['timezone'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      inboxReassignAfterMinutes: json['inbox_reassign_after_minutes'],
    );

Map<String, dynamic> _$AuthModelDataTenantToJson(
  _AuthModelDataTenant instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'status': instance.status,
  'timezone': instance.timezone,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'inbox_reassign_after_minutes': instance.inboxReassignAfterMinutes,
};
