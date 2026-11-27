import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
abstract class AuthModel with _$AuthModel {
  const factory AuthModel({
    required bool success,
    required String message,
    required AuthModelData data,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
}

@freezed
abstract class AuthModelData with _$AuthModelData {
  const factory AuthModelData({
    required AuthModelDataUser user,
    required AuthModelDataTenant? tenant,
    required String accessToken,
    required String refreshToken,
    required int sessionId,
  }) = _AuthModelData;

  factory AuthModelData.fromJson(Map<String, dynamic> json) =>
      _$AuthModelDataFromJson(json);
}

@freezed
abstract class AuthModelDataUser with _$AuthModelDataUser {
  const factory AuthModelDataUser({
    required String id,
    @JsonKey(name: 'tenant_id') required String tenantId,
    required String name,
    required String email,
    dynamic phone,
    required String status,
    @JsonKey(name: 'google_id') dynamic googleId,
    @JsonKey(name: 'auth_provider') required String authProvider,
    @JsonKey(name: 'last_login_at') String? lastLoginAt,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @Default([]) List<String> roles,
    @JsonKey(name: 'role_ids') @Default([]) List<int> roleIds,
    @Default([]) List<String> permissions,
    @JsonKey(name: 'role_permissions') @Default([]) List<String> rolePermissions,
    @JsonKey(name: 'permission_overrides')
    @Default([])
    List<dynamic> permissionOverrides,
  }) = _AuthModelDataUser;

  factory AuthModelDataUser.fromJson(Map<String, dynamic> json) =>
      _$AuthModelDataUserFromJson(json);
}

@freezed
abstract class AuthModelDataTenant with _$AuthModelDataTenant {
  const factory AuthModelDataTenant({
    required String id,
    required String name,
    required String slug,
    required String status,
    required String timezone,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'inbox_reassign_after_minutes')
    dynamic inboxReassignAfterMinutes,
  }) = _AuthModelDataTenant;

  factory AuthModelDataTenant.fromJson(Map<String, dynamic> json) =>
      _$AuthModelDataTenantFromJson(json);
}
