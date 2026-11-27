// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthModel {

 bool get success; String get message; AuthModelData get data;
/// Create a copy of AuthModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthModelCopyWith<AuthModel> get copyWith => _$AuthModelCopyWithImpl<AuthModel>(this as AuthModel, _$identity);

  /// Serializes this AuthModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AuthModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthModel&&(identical(other.success, _this.success) || other.success == _this.success)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AuthModel;
  return Object.hash(runtimeType,_this.success,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as AuthModel;
  return 'AuthModel(success: ${_this.success}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $AuthModelCopyWith<$Res>  {
  factory $AuthModelCopyWith(AuthModel value, $Res Function(AuthModel) _then) = _$AuthModelCopyWithImpl;
@useResult
$Res call({
 bool success, String message, AuthModelData data
});


$AuthModelDataCopyWith<$Res> get data;

}
/// @nodoc
class _$AuthModelCopyWithImpl<$Res>
    implements $AuthModelCopyWith<$Res> {
  _$AuthModelCopyWithImpl(this._self, this._then);

  final AuthModel _self;
  final $Res Function(AuthModel) _then;

/// Create a copy of AuthModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(AuthModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AuthModelData,
  ));
}
/// Create a copy of AuthModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthModelDataCopyWith<$Res> get data {
  
  return $AuthModelDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthModel].
extension AuthModelPatterns on AuthModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthModel value)  $default,){
final _that = this;
switch (_that) {
case _AuthModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthModel value)?  $default,){
final _that = this;
switch (_that) {
case _AuthModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  AuthModelData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthModel() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  AuthModelData data)  $default,) {final _that = this;
switch (_that) {
case _AuthModel():
return $default(_that.success,_that.message,_that.data);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  AuthModelData data)?  $default,) {final _that = this;
switch (_that) {
case _AuthModel() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthModel implements AuthModel {
  const _AuthModel({required this.success, required this.message, required this.data});
  factory _AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

@override final  bool success;
@override final  String message;
@override final  AuthModelData data;

/// Create a copy of AuthModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthModelCopyWith<_AuthModel> get copyWith => __$AuthModelCopyWithImpl<_AuthModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthModel&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,success,message,data);
}

@override
String toString() {
    return 'AuthModel(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$AuthModelCopyWith<$Res> implements $AuthModelCopyWith<$Res> {
  factory _$AuthModelCopyWith(_AuthModel value, $Res Function(_AuthModel) _then) = __$AuthModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, AuthModelData data
});


@override $AuthModelDataCopyWith<$Res> get data;

}
/// @nodoc
class __$AuthModelCopyWithImpl<$Res>
    implements _$AuthModelCopyWith<$Res> {
  __$AuthModelCopyWithImpl(this._self, this._then);

  final _AuthModel _self;
  final $Res Function(_AuthModel) _then;

/// Create a copy of AuthModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_AuthModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AuthModelData,
  ));
}

/// Create a copy of AuthModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthModelDataCopyWith<$Res> get data {
  
  return $AuthModelDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$AuthModelData {

 AuthModelDataUser get user; AuthModelDataTenant? get tenant; String get accessToken; String get refreshToken; int get sessionId;
/// Create a copy of AuthModelData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthModelDataCopyWith<AuthModelData> get copyWith => _$AuthModelDataCopyWithImpl<AuthModelData>(this as AuthModelData, _$identity);

  /// Serializes this AuthModelData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AuthModelData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthModelData&&(identical(other.user, _this.user) || other.user == _this.user)&&(identical(other.tenant, _this.tenant) || other.tenant == _this.tenant)&&(identical(other.accessToken, _this.accessToken) || other.accessToken == _this.accessToken)&&(identical(other.refreshToken, _this.refreshToken) || other.refreshToken == _this.refreshToken)&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AuthModelData;
  return Object.hash(runtimeType,_this.user,_this.tenant,_this.accessToken,_this.refreshToken,_this.sessionId);
}

@override
String toString() {
  final _this = this as AuthModelData;
  return 'AuthModelData(user: ${_this.user}, tenant: ${_this.tenant}, accessToken: ${_this.accessToken}, refreshToken: ${_this.refreshToken}, sessionId: ${_this.sessionId})';
}


}

/// @nodoc
abstract mixin class $AuthModelDataCopyWith<$Res>  {
  factory $AuthModelDataCopyWith(AuthModelData value, $Res Function(AuthModelData) _then) = _$AuthModelDataCopyWithImpl;
@useResult
$Res call({
 AuthModelDataUser user, AuthModelDataTenant? tenant, String accessToken, String refreshToken, int sessionId
});


$AuthModelDataUserCopyWith<$Res> get user;$AuthModelDataTenantCopyWith<$Res>? get tenant;

}
/// @nodoc
class _$AuthModelDataCopyWithImpl<$Res>
    implements $AuthModelDataCopyWith<$Res> {
  _$AuthModelDataCopyWithImpl(this._self, this._then);

  final AuthModelData _self;
  final $Res Function(AuthModelData) _then;

/// Create a copy of AuthModelData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? tenant = freezed,Object? accessToken = null,Object? refreshToken = null,Object? sessionId = null,}) {
  return _then(AuthModelData(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthModelDataUser,tenant: freezed == tenant ? _self.tenant : tenant // ignore: cast_nullable_to_non_nullable
as AuthModelDataTenant?,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of AuthModelData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthModelDataUserCopyWith<$Res> get user {
  
  return $AuthModelDataUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of AuthModelData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthModelDataTenantCopyWith<$Res>? get tenant {
    if (_self.tenant == null) {
    return null;
  }

  return $AuthModelDataTenantCopyWith<$Res>(_self.tenant!, (value) {
    return _then(_self.copyWith(tenant: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthModelData].
extension AuthModelDataPatterns on AuthModelData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthModelData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthModelData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthModelData value)  $default,){
final _that = this;
switch (_that) {
case _AuthModelData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthModelData value)?  $default,){
final _that = this;
switch (_that) {
case _AuthModelData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthModelDataUser user,  AuthModelDataTenant? tenant,  String accessToken,  String refreshToken,  int sessionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthModelData() when $default != null:
return $default(_that.user,_that.tenant,_that.accessToken,_that.refreshToken,_that.sessionId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthModelDataUser user,  AuthModelDataTenant? tenant,  String accessToken,  String refreshToken,  int sessionId)  $default,) {final _that = this;
switch (_that) {
case _AuthModelData():
return $default(_that.user,_that.tenant,_that.accessToken,_that.refreshToken,_that.sessionId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthModelDataUser user,  AuthModelDataTenant? tenant,  String accessToken,  String refreshToken,  int sessionId)?  $default,) {final _that = this;
switch (_that) {
case _AuthModelData() when $default != null:
return $default(_that.user,_that.tenant,_that.accessToken,_that.refreshToken,_that.sessionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthModelData implements AuthModelData {
  const _AuthModelData({required this.user, required this.tenant, required this.accessToken, required this.refreshToken, required this.sessionId});
  factory _AuthModelData.fromJson(Map<String, dynamic> json) => _$AuthModelDataFromJson(json);

@override final  AuthModelDataUser user;
@override final  AuthModelDataTenant? tenant;
@override final  String accessToken;
@override final  String refreshToken;
@override final  int sessionId;

/// Create a copy of AuthModelData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthModelDataCopyWith<_AuthModelData> get copyWith => __$AuthModelDataCopyWithImpl<_AuthModelData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthModelDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthModelData&&(identical(other.user, user) || other.user == user)&&(identical(other.tenant, tenant) || other.tenant == tenant)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,user,tenant,accessToken,refreshToken,sessionId);
}

@override
String toString() {
    return 'AuthModelData(user: $user, tenant: $tenant, accessToken: $accessToken, refreshToken: $refreshToken, sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class _$AuthModelDataCopyWith<$Res> implements $AuthModelDataCopyWith<$Res> {
  factory _$AuthModelDataCopyWith(_AuthModelData value, $Res Function(_AuthModelData) _then) = __$AuthModelDataCopyWithImpl;
@override @useResult
$Res call({
 AuthModelDataUser user, AuthModelDataTenant? tenant, String accessToken, String refreshToken, int sessionId
});


@override $AuthModelDataUserCopyWith<$Res> get user;@override $AuthModelDataTenantCopyWith<$Res>? get tenant;

}
/// @nodoc
class __$AuthModelDataCopyWithImpl<$Res>
    implements _$AuthModelDataCopyWith<$Res> {
  __$AuthModelDataCopyWithImpl(this._self, this._then);

  final _AuthModelData _self;
  final $Res Function(_AuthModelData) _then;

/// Create a copy of AuthModelData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? tenant = freezed,Object? accessToken = null,Object? refreshToken = null,Object? sessionId = null,}) {
  return _then(_AuthModelData(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthModelDataUser,tenant: freezed == tenant ? _self.tenant : tenant // ignore: cast_nullable_to_non_nullable
as AuthModelDataTenant?,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of AuthModelData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthModelDataUserCopyWith<$Res> get user {
  
  return $AuthModelDataUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of AuthModelData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthModelDataTenantCopyWith<$Res>? get tenant {
    if (_self.tenant == null) {
    return null;
  }

  return $AuthModelDataTenantCopyWith<$Res>(_self.tenant!, (value) {
    return _then(_self.copyWith(tenant: value));
  });
}
}


/// @nodoc
mixin _$AuthModelDataUser {

 String get id;@JsonKey(name: 'tenant_id') String get tenantId; String get name; String get email; dynamic get phone; String get status;@JsonKey(name: 'google_id') dynamic get googleId;@JsonKey(name: 'auth_provider') String get authProvider;@JsonKey(name: 'last_login_at') String? get lastLoginAt;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt; List<String> get roles;@JsonKey(name: 'role_ids') List<int> get roleIds; List<String> get permissions;@JsonKey(name: 'role_permissions') List<String> get rolePermissions;@JsonKey(name: 'permission_overrides') List<dynamic> get permissionOverrides;
/// Create a copy of AuthModelDataUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthModelDataUserCopyWith<AuthModelDataUser> get copyWith => _$AuthModelDataUserCopyWithImpl<AuthModelDataUser>(this as AuthModelDataUser, _$identity);

  /// Serializes this AuthModelDataUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AuthModelDataUser;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthModelDataUser&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tenantId, _this.tenantId) || other.tenantId == _this.tenantId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&const DeepCollectionEquality().equals(other.phone, _this.phone)&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.googleId, _this.googleId)&&(identical(other.authProvider, _this.authProvider) || other.authProvider == _this.authProvider)&&(identical(other.lastLoginAt, _this.lastLoginAt) || other.lastLoginAt == _this.lastLoginAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&const DeepCollectionEquality().equals(other.roles, _this.roles)&&const DeepCollectionEquality().equals(other.roleIds, _this.roleIds)&&const DeepCollectionEquality().equals(other.permissions, _this.permissions)&&const DeepCollectionEquality().equals(other.rolePermissions, _this.rolePermissions)&&const DeepCollectionEquality().equals(other.permissionOverrides, _this.permissionOverrides));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AuthModelDataUser;
  return Object.hash(runtimeType,_this.id,_this.tenantId,_this.name,_this.email,const DeepCollectionEquality().hash(_this.phone),_this.status,const DeepCollectionEquality().hash(_this.googleId),_this.authProvider,_this.lastLoginAt,_this.createdAt,_this.updatedAt,const DeepCollectionEquality().hash(_this.roles),const DeepCollectionEquality().hash(_this.roleIds),const DeepCollectionEquality().hash(_this.permissions),const DeepCollectionEquality().hash(_this.rolePermissions),const DeepCollectionEquality().hash(_this.permissionOverrides));
}

@override
String toString() {
  final _this = this as AuthModelDataUser;
  return 'AuthModelDataUser(id: ${_this.id}, tenantId: ${_this.tenantId}, name: ${_this.name}, email: ${_this.email}, phone: ${_this.phone}, status: ${_this.status}, googleId: ${_this.googleId}, authProvider: ${_this.authProvider}, lastLoginAt: ${_this.lastLoginAt}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, roles: ${_this.roles}, roleIds: ${_this.roleIds}, permissions: ${_this.permissions}, rolePermissions: ${_this.rolePermissions}, permissionOverrides: ${_this.permissionOverrides})';
}


}

/// @nodoc
abstract mixin class $AuthModelDataUserCopyWith<$Res>  {
  factory $AuthModelDataUserCopyWith(AuthModelDataUser value, $Res Function(AuthModelDataUser) _then) = _$AuthModelDataUserCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'tenant_id') String tenantId, String name, String email, dynamic phone, String status,@JsonKey(name: 'google_id') dynamic googleId,@JsonKey(name: 'auth_provider') String authProvider,@JsonKey(name: 'last_login_at') String? lastLoginAt,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt, List<String> roles,@JsonKey(name: 'role_ids') List<int> roleIds, List<String> permissions,@JsonKey(name: 'role_permissions') List<String> rolePermissions,@JsonKey(name: 'permission_overrides') List<dynamic> permissionOverrides
});




}
/// @nodoc
class _$AuthModelDataUserCopyWithImpl<$Res>
    implements $AuthModelDataUserCopyWith<$Res> {
  _$AuthModelDataUserCopyWithImpl(this._self, this._then);

  final AuthModelDataUser _self;
  final $Res Function(AuthModelDataUser) _then;

/// Create a copy of AuthModelDataUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tenantId = null,Object? name = null,Object? email = null,Object? phone = freezed,Object? status = null,Object? googleId = freezed,Object? authProvider = null,Object? lastLoginAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? roles = null,Object? roleIds = null,Object? permissions = null,Object? rolePermissions = null,Object? permissionOverrides = null,}) {
  return _then(AuthModelDataUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as dynamic,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,googleId: freezed == googleId ? _self.googleId : googleId // ignore: cast_nullable_to_non_nullable
as dynamic,authProvider: null == authProvider ? _self.authProvider : authProvider // ignore: cast_nullable_to_non_nullable
as String,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,roleIds: null == roleIds ? _self.roleIds : roleIds // ignore: cast_nullable_to_non_nullable
as List<int>,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,rolePermissions: null == rolePermissions ? _self.rolePermissions : rolePermissions // ignore: cast_nullable_to_non_nullable
as List<String>,permissionOverrides: null == permissionOverrides ? _self.permissionOverrides : permissionOverrides // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthModelDataUser].
extension AuthModelDataUserPatterns on AuthModelDataUser {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthModelDataUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthModelDataUser() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthModelDataUser value)  $default,){
final _that = this;
switch (_that) {
case _AuthModelDataUser():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthModelDataUser value)?  $default,){
final _that = this;
switch (_that) {
case _AuthModelDataUser() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'tenant_id')  String tenantId,  String name,  String email,  dynamic phone,  String status, @JsonKey(name: 'google_id')  dynamic googleId, @JsonKey(name: 'auth_provider')  String authProvider, @JsonKey(name: 'last_login_at')  String? lastLoginAt, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  List<String> roles, @JsonKey(name: 'role_ids')  List<int> roleIds,  List<String> permissions, @JsonKey(name: 'role_permissions')  List<String> rolePermissions, @JsonKey(name: 'permission_overrides')  List<dynamic> permissionOverrides)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthModelDataUser() when $default != null:
return $default(_that.id,_that.tenantId,_that.name,_that.email,_that.phone,_that.status,_that.googleId,_that.authProvider,_that.lastLoginAt,_that.createdAt,_that.updatedAt,_that.roles,_that.roleIds,_that.permissions,_that.rolePermissions,_that.permissionOverrides);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'tenant_id')  String tenantId,  String name,  String email,  dynamic phone,  String status, @JsonKey(name: 'google_id')  dynamic googleId, @JsonKey(name: 'auth_provider')  String authProvider, @JsonKey(name: 'last_login_at')  String? lastLoginAt, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  List<String> roles, @JsonKey(name: 'role_ids')  List<int> roleIds,  List<String> permissions, @JsonKey(name: 'role_permissions')  List<String> rolePermissions, @JsonKey(name: 'permission_overrides')  List<dynamic> permissionOverrides)  $default,) {final _that = this;
switch (_that) {
case _AuthModelDataUser():
return $default(_that.id,_that.tenantId,_that.name,_that.email,_that.phone,_that.status,_that.googleId,_that.authProvider,_that.lastLoginAt,_that.createdAt,_that.updatedAt,_that.roles,_that.roleIds,_that.permissions,_that.rolePermissions,_that.permissionOverrides);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'tenant_id')  String tenantId,  String name,  String email,  dynamic phone,  String status, @JsonKey(name: 'google_id')  dynamic googleId, @JsonKey(name: 'auth_provider')  String authProvider, @JsonKey(name: 'last_login_at')  String? lastLoginAt, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  List<String> roles, @JsonKey(name: 'role_ids')  List<int> roleIds,  List<String> permissions, @JsonKey(name: 'role_permissions')  List<String> rolePermissions, @JsonKey(name: 'permission_overrides')  List<dynamic> permissionOverrides)?  $default,) {final _that = this;
switch (_that) {
case _AuthModelDataUser() when $default != null:
return $default(_that.id,_that.tenantId,_that.name,_that.email,_that.phone,_that.status,_that.googleId,_that.authProvider,_that.lastLoginAt,_that.createdAt,_that.updatedAt,_that.roles,_that.roleIds,_that.permissions,_that.rolePermissions,_that.permissionOverrides);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthModelDataUser implements AuthModelDataUser {
  const _AuthModelDataUser({required this.id, @JsonKey(name: 'tenant_id') required this.tenantId, required this.name, required this.email, this.phone, required this.status, @JsonKey(name: 'google_id') this.googleId, @JsonKey(name: 'auth_provider') required this.authProvider, @JsonKey(name: 'last_login_at') this.lastLoginAt, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt,  List<String> roles = const [], @JsonKey(name: 'role_ids')  List<int> roleIds = const [],  List<String> permissions = const [], @JsonKey(name: 'role_permissions')  List<String> rolePermissions = const [], @JsonKey(name: 'permission_overrides')  List<dynamic> permissionOverrides = const []}): _roles = roles,_roleIds = roleIds,_permissions = permissions,_rolePermissions = rolePermissions,_permissionOverrides = permissionOverrides;
  factory _AuthModelDataUser.fromJson(Map<String, dynamic> json) => _$AuthModelDataUserFromJson(json);

@override final  String id;
@override@JsonKey(name: 'tenant_id') final  String tenantId;
@override final  String name;
@override final  String email;
@override final  dynamic phone;
@override final  String status;
@override@JsonKey(name: 'google_id') final  dynamic googleId;
@override@JsonKey(name: 'auth_provider') final  String authProvider;
@override@JsonKey(name: 'last_login_at') final  String? lastLoginAt;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;
 final  List<String> _roles;
@override@JsonKey() List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

 final  List<int> _roleIds;
@override@JsonKey(name: 'role_ids') List<int> get roleIds {
  if (_roleIds is EqualUnmodifiableListView) return _roleIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roleIds);
}

 final  List<String> _permissions;
@override@JsonKey() List<String> get permissions {
  if (_permissions is EqualUnmodifiableListView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissions);
}

 final  List<String> _rolePermissions;
@override@JsonKey(name: 'role_permissions') List<String> get rolePermissions {
  if (_rolePermissions is EqualUnmodifiableListView) return _rolePermissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rolePermissions);
}

 final  List<dynamic> _permissionOverrides;
@override@JsonKey(name: 'permission_overrides') List<dynamic> get permissionOverrides {
  if (_permissionOverrides is EqualUnmodifiableListView) return _permissionOverrides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissionOverrides);
}


/// Create a copy of AuthModelDataUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthModelDataUserCopyWith<_AuthModelDataUser> get copyWith => __$AuthModelDataUserCopyWithImpl<_AuthModelDataUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthModelDataUserToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthModelDataUser&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&const DeepCollectionEquality().equals(other.phone, phone)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.googleId, googleId)&&(identical(other.authProvider, authProvider) || other.authProvider == authProvider)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.roles, _roles)&&const DeepCollectionEquality().equals(other.roleIds, _roleIds)&&const DeepCollectionEquality().equals(other.permissions, _permissions)&&const DeepCollectionEquality().equals(other.rolePermissions, _rolePermissions)&&const DeepCollectionEquality().equals(other.permissionOverrides, _permissionOverrides));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,tenantId,name,email,const DeepCollectionEquality().hash(phone),status,const DeepCollectionEquality().hash(googleId),authProvider,lastLoginAt,createdAt,updatedAt,const DeepCollectionEquality().hash(_roles),const DeepCollectionEquality().hash(_roleIds),const DeepCollectionEquality().hash(_permissions),const DeepCollectionEquality().hash(_rolePermissions),const DeepCollectionEquality().hash(_permissionOverrides));
}

@override
String toString() {
    return 'AuthModelDataUser(id: $id, tenantId: $tenantId, name: $name, email: $email, phone: $phone, status: $status, googleId: $googleId, authProvider: $authProvider, lastLoginAt: $lastLoginAt, createdAt: $createdAt, updatedAt: $updatedAt, roles: $roles, roleIds: $roleIds, permissions: $permissions, rolePermissions: $rolePermissions, permissionOverrides: $permissionOverrides)';
}


}

/// @nodoc
abstract mixin class _$AuthModelDataUserCopyWith<$Res> implements $AuthModelDataUserCopyWith<$Res> {
  factory _$AuthModelDataUserCopyWith(_AuthModelDataUser value, $Res Function(_AuthModelDataUser) _then) = __$AuthModelDataUserCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'tenant_id') String tenantId, String name, String email, dynamic phone, String status,@JsonKey(name: 'google_id') dynamic googleId,@JsonKey(name: 'auth_provider') String authProvider,@JsonKey(name: 'last_login_at') String? lastLoginAt,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt, List<String> roles,@JsonKey(name: 'role_ids') List<int> roleIds, List<String> permissions,@JsonKey(name: 'role_permissions') List<String> rolePermissions,@JsonKey(name: 'permission_overrides') List<dynamic> permissionOverrides
});




}
/// @nodoc
class __$AuthModelDataUserCopyWithImpl<$Res>
    implements _$AuthModelDataUserCopyWith<$Res> {
  __$AuthModelDataUserCopyWithImpl(this._self, this._then);

  final _AuthModelDataUser _self;
  final $Res Function(_AuthModelDataUser) _then;

/// Create a copy of AuthModelDataUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tenantId = null,Object? name = null,Object? email = null,Object? phone = freezed,Object? status = null,Object? googleId = freezed,Object? authProvider = null,Object? lastLoginAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? roles = null,Object? roleIds = null,Object? permissions = null,Object? rolePermissions = null,Object? permissionOverrides = null,}) {
  return _then(_AuthModelDataUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as dynamic,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,googleId: freezed == googleId ? _self.googleId : googleId // ignore: cast_nullable_to_non_nullable
as dynamic,authProvider: null == authProvider ? _self.authProvider : authProvider // ignore: cast_nullable_to_non_nullable
as String,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,roleIds: null == roleIds ? _self._roleIds : roleIds // ignore: cast_nullable_to_non_nullable
as List<int>,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,rolePermissions: null == rolePermissions ? _self._rolePermissions : rolePermissions // ignore: cast_nullable_to_non_nullable
as List<String>,permissionOverrides: null == permissionOverrides ? _self._permissionOverrides : permissionOverrides // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}


/// @nodoc
mixin _$AuthModelDataTenant {

 String get id; String get name; String get slug; String get status; String get timezone;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt;@JsonKey(name: 'inbox_reassign_after_minutes') dynamic get inboxReassignAfterMinutes;
/// Create a copy of AuthModelDataTenant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthModelDataTenantCopyWith<AuthModelDataTenant> get copyWith => _$AuthModelDataTenantCopyWithImpl<AuthModelDataTenant>(this as AuthModelDataTenant, _$identity);

  /// Serializes this AuthModelDataTenant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AuthModelDataTenant;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthModelDataTenant&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.timezone, _this.timezone) || other.timezone == _this.timezone)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&const DeepCollectionEquality().equals(other.inboxReassignAfterMinutes, _this.inboxReassignAfterMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AuthModelDataTenant;
  return Object.hash(runtimeType,_this.id,_this.name,_this.slug,_this.status,_this.timezone,_this.createdAt,_this.updatedAt,const DeepCollectionEquality().hash(_this.inboxReassignAfterMinutes));
}

@override
String toString() {
  final _this = this as AuthModelDataTenant;
  return 'AuthModelDataTenant(id: ${_this.id}, name: ${_this.name}, slug: ${_this.slug}, status: ${_this.status}, timezone: ${_this.timezone}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, inboxReassignAfterMinutes: ${_this.inboxReassignAfterMinutes})';
}


}

/// @nodoc
abstract mixin class $AuthModelDataTenantCopyWith<$Res>  {
  factory $AuthModelDataTenantCopyWith(AuthModelDataTenant value, $Res Function(AuthModelDataTenant) _then) = _$AuthModelDataTenantCopyWithImpl;
@useResult
$Res call({
 String id, String name, String slug, String status, String timezone,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt,@JsonKey(name: 'inbox_reassign_after_minutes') dynamic inboxReassignAfterMinutes
});




}
/// @nodoc
class _$AuthModelDataTenantCopyWithImpl<$Res>
    implements $AuthModelDataTenantCopyWith<$Res> {
  _$AuthModelDataTenantCopyWithImpl(this._self, this._then);

  final AuthModelDataTenant _self;
  final $Res Function(AuthModelDataTenant) _then;

/// Create a copy of AuthModelDataTenant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? status = null,Object? timezone = null,Object? createdAt = null,Object? updatedAt = null,Object? inboxReassignAfterMinutes = freezed,}) {
  return _then(AuthModelDataTenant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,inboxReassignAfterMinutes: freezed == inboxReassignAfterMinutes ? _self.inboxReassignAfterMinutes : inboxReassignAfterMinutes // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthModelDataTenant].
extension AuthModelDataTenantPatterns on AuthModelDataTenant {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthModelDataTenant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthModelDataTenant() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthModelDataTenant value)  $default,){
final _that = this;
switch (_that) {
case _AuthModelDataTenant():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthModelDataTenant value)?  $default,){
final _that = this;
switch (_that) {
case _AuthModelDataTenant() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String slug,  String status,  String timezone, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt, @JsonKey(name: 'inbox_reassign_after_minutes')  dynamic inboxReassignAfterMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthModelDataTenant() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.status,_that.timezone,_that.createdAt,_that.updatedAt,_that.inboxReassignAfterMinutes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String slug,  String status,  String timezone, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt, @JsonKey(name: 'inbox_reassign_after_minutes')  dynamic inboxReassignAfterMinutes)  $default,) {final _that = this;
switch (_that) {
case _AuthModelDataTenant():
return $default(_that.id,_that.name,_that.slug,_that.status,_that.timezone,_that.createdAt,_that.updatedAt,_that.inboxReassignAfterMinutes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String slug,  String status,  String timezone, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt, @JsonKey(name: 'inbox_reassign_after_minutes')  dynamic inboxReassignAfterMinutes)?  $default,) {final _that = this;
switch (_that) {
case _AuthModelDataTenant() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.status,_that.timezone,_that.createdAt,_that.updatedAt,_that.inboxReassignAfterMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthModelDataTenant implements AuthModelDataTenant {
  const _AuthModelDataTenant({required this.id, required this.name, required this.slug, required this.status, required this.timezone, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, @JsonKey(name: 'inbox_reassign_after_minutes') this.inboxReassignAfterMinutes});
  factory _AuthModelDataTenant.fromJson(Map<String, dynamic> json) => _$AuthModelDataTenantFromJson(json);

@override final  String id;
@override final  String name;
@override final  String slug;
@override final  String status;
@override final  String timezone;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;
@override@JsonKey(name: 'inbox_reassign_after_minutes') final  dynamic inboxReassignAfterMinutes;

/// Create a copy of AuthModelDataTenant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthModelDataTenantCopyWith<_AuthModelDataTenant> get copyWith => __$AuthModelDataTenantCopyWithImpl<_AuthModelDataTenant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthModelDataTenantToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthModelDataTenant&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.status, status) || other.status == status)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.inboxReassignAfterMinutes, inboxReassignAfterMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,slug,status,timezone,createdAt,updatedAt,const DeepCollectionEquality().hash(inboxReassignAfterMinutes));
}

@override
String toString() {
    return 'AuthModelDataTenant(id: $id, name: $name, slug: $slug, status: $status, timezone: $timezone, createdAt: $createdAt, updatedAt: $updatedAt, inboxReassignAfterMinutes: $inboxReassignAfterMinutes)';
}


}

/// @nodoc
abstract mixin class _$AuthModelDataTenantCopyWith<$Res> implements $AuthModelDataTenantCopyWith<$Res> {
  factory _$AuthModelDataTenantCopyWith(_AuthModelDataTenant value, $Res Function(_AuthModelDataTenant) _then) = __$AuthModelDataTenantCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String slug, String status, String timezone,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt,@JsonKey(name: 'inbox_reassign_after_minutes') dynamic inboxReassignAfterMinutes
});




}
/// @nodoc
class __$AuthModelDataTenantCopyWithImpl<$Res>
    implements _$AuthModelDataTenantCopyWith<$Res> {
  __$AuthModelDataTenantCopyWithImpl(this._self, this._then);

  final _AuthModelDataTenant _self;
  final $Res Function(_AuthModelDataTenant) _then;

/// Create a copy of AuthModelDataTenant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? status = null,Object? timezone = null,Object? createdAt = null,Object? updatedAt = null,Object? inboxReassignAfterMinutes = freezed,}) {
  return _then(_AuthModelDataTenant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,inboxReassignAfterMinutes: freezed == inboxReassignAfterMinutes ? _self.inboxReassignAfterMinutes : inboxReassignAfterMinutes // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
