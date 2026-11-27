// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListConversationsParams {

 String get status; String get channel; String? get search; int get page; int get limit;
/// Create a copy of ListConversationsParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListConversationsParamsCopyWith<ListConversationsParams> get copyWith => _$ListConversationsParamsCopyWithImpl<ListConversationsParams>(this as ListConversationsParams, _$identity);

  /// Serializes this ListConversationsParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ListConversationsParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListConversationsParams&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.channel, _this.channel) || other.channel == _this.channel)&&(identical(other.search, _this.search) || other.search == _this.search)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.limit, _this.limit) || other.limit == _this.limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ListConversationsParams;
  return Object.hash(runtimeType,_this.status,_this.channel,_this.search,_this.page,_this.limit);
}

@override
String toString() {
  final _this = this as ListConversationsParams;
  return 'ListConversationsParams(status: ${_this.status}, channel: ${_this.channel}, search: ${_this.search}, page: ${_this.page}, limit: ${_this.limit})';
}


}

/// @nodoc
abstract mixin class $ListConversationsParamsCopyWith<$Res>  {
  factory $ListConversationsParamsCopyWith(ListConversationsParams value, $Res Function(ListConversationsParams) _then) = _$ListConversationsParamsCopyWithImpl;
@useResult
$Res call({
 String status, String channel, String? search, int page, int limit
});




}
/// @nodoc
class _$ListConversationsParamsCopyWithImpl<$Res>
    implements $ListConversationsParamsCopyWith<$Res> {
  _$ListConversationsParamsCopyWithImpl(this._self, this._then);

  final ListConversationsParams _self;
  final $Res Function(ListConversationsParams) _then;

/// Create a copy of ListConversationsParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? channel = null,Object? search = freezed,Object? page = null,Object? limit = null,}) {
  return _then(ListConversationsParams(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ListConversationsParams].
extension ListConversationsParamsPatterns on ListConversationsParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListConversationsParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListConversationsParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListConversationsParams value)  $default,){
final _that = this;
switch (_that) {
case _ListConversationsParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListConversationsParams value)?  $default,){
final _that = this;
switch (_that) {
case _ListConversationsParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String channel,  String? search,  int page,  int limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListConversationsParams() when $default != null:
return $default(_that.status,_that.channel,_that.search,_that.page,_that.limit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String channel,  String? search,  int page,  int limit)  $default,) {final _that = this;
switch (_that) {
case _ListConversationsParams():
return $default(_that.status,_that.channel,_that.search,_that.page,_that.limit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String channel,  String? search,  int page,  int limit)?  $default,) {final _that = this;
switch (_that) {
case _ListConversationsParams() when $default != null:
return $default(_that.status,_that.channel,_that.search,_that.page,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListConversationsParams implements ListConversationsParams {
  const _ListConversationsParams({this.status = 'all', this.channel = 'whatsapp', this.search, this.page = 1, this.limit = 30});
  factory _ListConversationsParams.fromJson(Map<String, dynamic> json) => _$ListConversationsParamsFromJson(json);

@override@JsonKey() final  String status;
@override@JsonKey() final  String channel;
@override final  String? search;
@override@JsonKey() final  int page;
@override@JsonKey() final  int limit;

/// Create a copy of ListConversationsParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListConversationsParamsCopyWith<_ListConversationsParams> get copyWith => __$ListConversationsParamsCopyWithImpl<_ListConversationsParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListConversationsParamsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListConversationsParams&&(identical(other.status, status) || other.status == status)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.search, search) || other.search == search)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,channel,search,page,limit);
}

@override
String toString() {
    return 'ListConversationsParams(status: $status, channel: $channel, search: $search, page: $page, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$ListConversationsParamsCopyWith<$Res> implements $ListConversationsParamsCopyWith<$Res> {
  factory _$ListConversationsParamsCopyWith(_ListConversationsParams value, $Res Function(_ListConversationsParams) _then) = __$ListConversationsParamsCopyWithImpl;
@override @useResult
$Res call({
 String status, String channel, String? search, int page, int limit
});




}
/// @nodoc
class __$ListConversationsParamsCopyWithImpl<$Res>
    implements _$ListConversationsParamsCopyWith<$Res> {
  __$ListConversationsParamsCopyWithImpl(this._self, this._then);

  final _ListConversationsParams _self;
  final $Res Function(_ListConversationsParams) _then;

/// Create a copy of ListConversationsParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? channel = null,Object? search = freezed,Object? page = null,Object? limit = null,}) {
  return _then(_ListConversationsParams(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ListMessagesParams {

 int get conversationId; int get page; int get limit;
/// Create a copy of ListMessagesParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListMessagesParamsCopyWith<ListMessagesParams> get copyWith => _$ListMessagesParamsCopyWithImpl<ListMessagesParams>(this as ListMessagesParams, _$identity);

  /// Serializes this ListMessagesParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ListMessagesParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListMessagesParams&&(identical(other.conversationId, _this.conversationId) || other.conversationId == _this.conversationId)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.limit, _this.limit) || other.limit == _this.limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ListMessagesParams;
  return Object.hash(runtimeType,_this.conversationId,_this.page,_this.limit);
}

@override
String toString() {
  final _this = this as ListMessagesParams;
  return 'ListMessagesParams(conversationId: ${_this.conversationId}, page: ${_this.page}, limit: ${_this.limit})';
}


}

/// @nodoc
abstract mixin class $ListMessagesParamsCopyWith<$Res>  {
  factory $ListMessagesParamsCopyWith(ListMessagesParams value, $Res Function(ListMessagesParams) _then) = _$ListMessagesParamsCopyWithImpl;
@useResult
$Res call({
 int conversationId, int page, int limit
});




}
/// @nodoc
class _$ListMessagesParamsCopyWithImpl<$Res>
    implements $ListMessagesParamsCopyWith<$Res> {
  _$ListMessagesParamsCopyWithImpl(this._self, this._then);

  final ListMessagesParams _self;
  final $Res Function(ListMessagesParams) _then;

/// Create a copy of ListMessagesParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversationId = null,Object? page = null,Object? limit = null,}) {
  return _then(ListMessagesParams(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ListMessagesParams].
extension ListMessagesParamsPatterns on ListMessagesParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListMessagesParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListMessagesParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListMessagesParams value)  $default,){
final _that = this;
switch (_that) {
case _ListMessagesParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListMessagesParams value)?  $default,){
final _that = this;
switch (_that) {
case _ListMessagesParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int conversationId,  int page,  int limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListMessagesParams() when $default != null:
return $default(_that.conversationId,_that.page,_that.limit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int conversationId,  int page,  int limit)  $default,) {final _that = this;
switch (_that) {
case _ListMessagesParams():
return $default(_that.conversationId,_that.page,_that.limit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int conversationId,  int page,  int limit)?  $default,) {final _that = this;
switch (_that) {
case _ListMessagesParams() when $default != null:
return $default(_that.conversationId,_that.page,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListMessagesParams implements ListMessagesParams {
  const _ListMessagesParams({required this.conversationId, this.page = 1, this.limit = 50});
  factory _ListMessagesParams.fromJson(Map<String, dynamic> json) => _$ListMessagesParamsFromJson(json);

@override final  int conversationId;
@override@JsonKey() final  int page;
@override@JsonKey() final  int limit;

/// Create a copy of ListMessagesParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListMessagesParamsCopyWith<_ListMessagesParams> get copyWith => __$ListMessagesParamsCopyWithImpl<_ListMessagesParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListMessagesParamsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListMessagesParams&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,conversationId,page,limit);
}

@override
String toString() {
    return 'ListMessagesParams(conversationId: $conversationId, page: $page, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$ListMessagesParamsCopyWith<$Res> implements $ListMessagesParamsCopyWith<$Res> {
  factory _$ListMessagesParamsCopyWith(_ListMessagesParams value, $Res Function(_ListMessagesParams) _then) = __$ListMessagesParamsCopyWithImpl;
@override @useResult
$Res call({
 int conversationId, int page, int limit
});




}
/// @nodoc
class __$ListMessagesParamsCopyWithImpl<$Res>
    implements _$ListMessagesParamsCopyWith<$Res> {
  __$ListMessagesParamsCopyWithImpl(this._self, this._then);

  final _ListMessagesParams _self;
  final $Res Function(_ListMessagesParams) _then;

/// Create a copy of ListMessagesParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? page = null,Object? limit = null,}) {
  return _then(_ListMessagesParams(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SendReplyParams {

 int get conversationId; String? get body;@JsonKey(name: 'template_id') int? get templateId;
/// Create a copy of SendReplyParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendReplyParamsCopyWith<SendReplyParams> get copyWith => _$SendReplyParamsCopyWithImpl<SendReplyParams>(this as SendReplyParams, _$identity);

  /// Serializes this SendReplyParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SendReplyParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendReplyParams&&(identical(other.conversationId, _this.conversationId) || other.conversationId == _this.conversationId)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.templateId, _this.templateId) || other.templateId == _this.templateId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SendReplyParams;
  return Object.hash(runtimeType,_this.conversationId,_this.body,_this.templateId);
}

@override
String toString() {
  final _this = this as SendReplyParams;
  return 'SendReplyParams(conversationId: ${_this.conversationId}, body: ${_this.body}, templateId: ${_this.templateId})';
}


}

/// @nodoc
abstract mixin class $SendReplyParamsCopyWith<$Res>  {
  factory $SendReplyParamsCopyWith(SendReplyParams value, $Res Function(SendReplyParams) _then) = _$SendReplyParamsCopyWithImpl;
@useResult
$Res call({
 int conversationId, String? body,@JsonKey(name: 'template_id') int? templateId
});




}
/// @nodoc
class _$SendReplyParamsCopyWithImpl<$Res>
    implements $SendReplyParamsCopyWith<$Res> {
  _$SendReplyParamsCopyWithImpl(this._self, this._then);

  final SendReplyParams _self;
  final $Res Function(SendReplyParams) _then;

/// Create a copy of SendReplyParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversationId = null,Object? body = freezed,Object? templateId = freezed,}) {
  return _then(SendReplyParams(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SendReplyParams].
extension SendReplyParamsPatterns on SendReplyParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendReplyParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendReplyParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendReplyParams value)  $default,){
final _that = this;
switch (_that) {
case _SendReplyParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendReplyParams value)?  $default,){
final _that = this;
switch (_that) {
case _SendReplyParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int conversationId,  String? body, @JsonKey(name: 'template_id')  int? templateId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendReplyParams() when $default != null:
return $default(_that.conversationId,_that.body,_that.templateId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int conversationId,  String? body, @JsonKey(name: 'template_id')  int? templateId)  $default,) {final _that = this;
switch (_that) {
case _SendReplyParams():
return $default(_that.conversationId,_that.body,_that.templateId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int conversationId,  String? body, @JsonKey(name: 'template_id')  int? templateId)?  $default,) {final _that = this;
switch (_that) {
case _SendReplyParams() when $default != null:
return $default(_that.conversationId,_that.body,_that.templateId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendReplyParams implements SendReplyParams {
  const _SendReplyParams({required this.conversationId, this.body, @JsonKey(name: 'template_id') this.templateId});
  factory _SendReplyParams.fromJson(Map<String, dynamic> json) => _$SendReplyParamsFromJson(json);

@override final  int conversationId;
@override final  String? body;
@override@JsonKey(name: 'template_id') final  int? templateId;

/// Create a copy of SendReplyParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendReplyParamsCopyWith<_SendReplyParams> get copyWith => __$SendReplyParamsCopyWithImpl<_SendReplyParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendReplyParamsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendReplyParams&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.body, body) || other.body == body)&&(identical(other.templateId, templateId) || other.templateId == templateId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,conversationId,body,templateId);
}

@override
String toString() {
    return 'SendReplyParams(conversationId: $conversationId, body: $body, templateId: $templateId)';
}


}

/// @nodoc
abstract mixin class _$SendReplyParamsCopyWith<$Res> implements $SendReplyParamsCopyWith<$Res> {
  factory _$SendReplyParamsCopyWith(_SendReplyParams value, $Res Function(_SendReplyParams) _then) = __$SendReplyParamsCopyWithImpl;
@override @useResult
$Res call({
 int conversationId, String? body,@JsonKey(name: 'template_id') int? templateId
});




}
/// @nodoc
class __$SendReplyParamsCopyWithImpl<$Res>
    implements _$SendReplyParamsCopyWith<$Res> {
  __$SendReplyParamsCopyWithImpl(this._self, this._then);

  final _SendReplyParams _self;
  final $Res Function(_SendReplyParams) _then;

/// Create a copy of SendReplyParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? body = freezed,Object? templateId = freezed,}) {
  return _then(_SendReplyParams(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
