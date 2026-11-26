import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';



@freezed
abstract  class AuthModel with _$AuthModel {
  const factory AuthModel({
    required bool success,
    required String message,
    required AuthModelData data,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);
}

@freezed
abstract class AuthModelData with _$AuthModelData {
  const factory AuthModelData({
    required AuthModelDataUser user,
    required AuthModelDataTenant tenant,
    required String accessToken,
    required String refreshToken,
    required int sessionId,
  }) = _AuthModelData;

  factory AuthModelData.fromJson(Map<String, dynamic> json) => _$AuthModelDataFromJson(json);
}

@freezed
abstract class AuthModelDataUser with _$AuthModelDataUser {
  const factory AuthModelDataUser({
    required String id,
    required String tenantId,
    required String name,
    required String email,
    required dynamic? phone,
    required String status,
    required dynamic? googleId,
    required String authProvider,
    required String lastLoginAt,
    required String createdAt,
    required String updatedAt,
    required List<String> roles,
    required List<int> roleIds,
    required List<String> permissions,
    required List<String> rolePermissions,
    required List<dynamic> permissionOverrides,
  }) = _AuthModelDataUser;

  factory AuthModelDataUser.fromJson(Map<String, dynamic> json) => _$AuthModelDataUserFromJson(json);
}

@freezed
abstract class AuthModelDataTenant with _$AuthModelDataTenant {
  const factory AuthModelDataTenant({
    required String id,
    required String name,
    required String slug,
    required String status,
    required String timezone,
    required String createdAt,
    required String updatedAt,
    required dynamic? inboxReassignAfterMinutes,
  }) = _AuthModelDataTenant;

  factory AuthModelDataTenant.fromJson(Map<String, dynamic> json) => _$AuthModelDataTenantFromJson(json);
}