// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_controller_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthControllerState {

 AuthModel? get authModel; bool get isLoading; String? get errorMessage;
/// Create a copy of AuthControllerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthControllerStateCopyWith<AuthControllerState> get copyWith => _$AuthControllerStateCopyWithImpl<AuthControllerState>(this as AuthControllerState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AuthControllerState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthControllerState&&(identical(other.authModel, _this.authModel) || other.authModel == _this.authModel)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as AuthControllerState;
  return Object.hash(runtimeType,_this.authModel,_this.isLoading,_this.errorMessage);
}

@override
String toString() {
  final _this = this as AuthControllerState;
  return 'AuthControllerState(authModel: ${_this.authModel}, isLoading: ${_this.isLoading}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $AuthControllerStateCopyWith<$Res>  {
  factory $AuthControllerStateCopyWith(AuthControllerState value, $Res Function(AuthControllerState) _then) = _$AuthControllerStateCopyWithImpl;
@useResult
$Res call({
 AuthModel? authModel, bool isLoading, String? errorMessage
});


$AuthModelCopyWith<$Res>? get authModel;

}
/// @nodoc
class _$AuthControllerStateCopyWithImpl<$Res>
    implements $AuthControllerStateCopyWith<$Res> {
  _$AuthControllerStateCopyWithImpl(this._self, this._then);

  final AuthControllerState _self;
  final $Res Function(AuthControllerState) _then;

/// Create a copy of AuthControllerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authModel = freezed,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(AuthControllerState(
authModel: freezed == authModel ? _self.authModel : authModel // ignore: cast_nullable_to_non_nullable
as AuthModel?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AuthControllerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthModelCopyWith<$Res>? get authModel {
    if (_self.authModel == null) {
    return null;
  }

  return $AuthModelCopyWith<$Res>(_self.authModel!, (value) {
    return _then(_self.copyWith(authModel: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthControllerState].
extension AuthControllerStatePatterns on AuthControllerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthControllerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthControllerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthControllerState value)  $default,){
final _that = this;
switch (_that) {
case _AuthControllerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthControllerState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthControllerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthModel? authModel,  bool isLoading,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthControllerState() when $default != null:
return $default(_that.authModel,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthModel? authModel,  bool isLoading,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AuthControllerState():
return $default(_that.authModel,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthModel? authModel,  bool isLoading,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AuthControllerState() when $default != null:
return $default(_that.authModel,_that.isLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AuthControllerState implements AuthControllerState {
  const _AuthControllerState({required this.authModel, required this.isLoading, this.errorMessage});
  

@override final  AuthModel? authModel;
@override final  bool isLoading;
@override final  String? errorMessage;

/// Create a copy of AuthControllerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthControllerStateCopyWith<_AuthControllerState> get copyWith => __$AuthControllerStateCopyWithImpl<_AuthControllerState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthControllerState&&(identical(other.authModel, authModel) || other.authModel == authModel)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,authModel,isLoading,errorMessage);
}

@override
String toString() {
    return 'AuthControllerState(authModel: $authModel, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AuthControllerStateCopyWith<$Res> implements $AuthControllerStateCopyWith<$Res> {
  factory _$AuthControllerStateCopyWith(_AuthControllerState value, $Res Function(_AuthControllerState) _then) = __$AuthControllerStateCopyWithImpl;
@override @useResult
$Res call({
 AuthModel? authModel, bool isLoading, String? errorMessage
});


@override $AuthModelCopyWith<$Res>? get authModel;

}
/// @nodoc
class __$AuthControllerStateCopyWithImpl<$Res>
    implements _$AuthControllerStateCopyWith<$Res> {
  __$AuthControllerStateCopyWithImpl(this._self, this._then);

  final _AuthControllerState _self;
  final $Res Function(_AuthControllerState) _then;

/// Create a copy of AuthControllerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authModel = freezed,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_AuthControllerState(
authModel: freezed == authModel ? _self.authModel : authModel // ignore: cast_nullable_to_non_nullable
as AuthModel?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AuthControllerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthModelCopyWith<$Res>? get authModel {
    if (_self.authModel == null) {
    return null;
  }

  return $AuthModelCopyWith<$Res>(_self.authModel!, (value) {
    return _then(_self.copyWith(authModel: value));
  });
}
}

// dart format on
