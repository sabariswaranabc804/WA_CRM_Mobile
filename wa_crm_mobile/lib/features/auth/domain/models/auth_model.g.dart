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
      tenant: AuthModelDataTenant.fromJson(
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
      tenantId: json['tenantId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'],
      status: json['status'] as String,
      googleId: json['googleId'],
      authProvider: json['authProvider'] as String,
      lastLoginAt: json['lastLoginAt'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      roleIds: (json['roleIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      rolePermissions: (json['rolePermissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      permissionOverrides: json['permissionOverrides'] as List<dynamic>,
    );

Map<String, dynamic> _$AuthModelDataUserToJson(_AuthModelDataUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'status': instance.status,
      'googleId': instance.googleId,
      'authProvider': instance.authProvider,
      'lastLoginAt': instance.lastLoginAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'roles': instance.roles,
      'roleIds': instance.roleIds,
      'permissions': instance.permissions,
      'rolePermissions': instance.rolePermissions,
      'permissionOverrides': instance.permissionOverrides,
    };

_AuthModelDataTenant _$AuthModelDataTenantFromJson(Map<String, dynamic> json) =>
    _AuthModelDataTenant(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      status: json['status'] as String,
      timezone: json['timezone'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      inboxReassignAfterMinutes: json['inboxReassignAfterMinutes'],
    );

Map<String, dynamic> _$AuthModelDataTenantToJson(
  _AuthModelDataTenant instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'status': instance.status,
  'timezone': instance.timezone,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'inboxReassignAfterMinutes': instance.inboxReassignAfterMinutes,
};
