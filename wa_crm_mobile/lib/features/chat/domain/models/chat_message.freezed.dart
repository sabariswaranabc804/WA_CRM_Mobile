// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatMessage {

@JsonKey(fromJson: asInt) int get id;@JsonKey(name: 'conversation_id', fromJson: asInt) int get conversationId; String get direction;@JsonKey(name: 'sender_type') String? get senderType;@JsonKey(name: 'content_type') String? get contentType; String? get body;@JsonKey(name: 'template_id', fromJson: asIntOrNull) int? get templateId; String get status;@JsonKey(name: 'error_message') String? get errorMessage;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.conversationId, _this.conversationId) || other.conversationId == _this.conversationId)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.senderType, _this.senderType) || other.senderType == _this.senderType)&&(identical(other.contentType, _this.contentType) || other.contentType == _this.contentType)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.templateId, _this.templateId) || other.templateId == _this.templateId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatMessage;
  return Object.hash(runtimeType,_this.id,_this.conversationId,_this.direction,_this.senderType,_this.contentType,_this.body,_this.templateId,_this.status,_this.errorMessage,_this.createdAt);
}

@override
String toString() {
  final _this = this as ChatMessage;
  return 'ChatMessage(id: ${_this.id}, conversationId: ${_this.conversationId}, direction: ${_this.direction}, senderType: ${_this.senderType}, contentType: ${_this.contentType}, body: ${_this.body}, templateId: ${_this.templateId}, status: ${_this.status}, errorMessage: ${_this.errorMessage}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: asInt) int id,@JsonKey(name: 'conversation_id', fromJson: asInt) int conversationId, String direction,@JsonKey(name: 'sender_type') String? senderType,@JsonKey(name: 'content_type') String? contentType, String? body,@JsonKey(name: 'template_id', fromJson: asIntOrNull) int? templateId, String status,@JsonKey(name: 'error_message') String? errorMessage,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversationId = null,Object? direction = null,Object? senderType = freezed,Object? contentType = freezed,Object? body = freezed,Object? templateId = freezed,Object? status = null,Object? errorMessage = freezed,Object? createdAt = freezed,}) {
  return _then(ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,senderType: freezed == senderType ? _self.senderType : senderType // ignore: cast_nullable_to_non_nullable
as String?,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: asInt)  int id, @JsonKey(name: 'conversation_id', fromJson: asInt)  int conversationId,  String direction, @JsonKey(name: 'sender_type')  String? senderType, @JsonKey(name: 'content_type')  String? contentType,  String? body, @JsonKey(name: 'template_id', fromJson: asIntOrNull)  int? templateId,  String status, @JsonKey(name: 'error_message')  String? errorMessage, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.conversationId,_that.direction,_that.senderType,_that.contentType,_that.body,_that.templateId,_that.status,_that.errorMessage,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: asInt)  int id, @JsonKey(name: 'conversation_id', fromJson: asInt)  int conversationId,  String direction, @JsonKey(name: 'sender_type')  String? senderType, @JsonKey(name: 'content_type')  String? contentType,  String? body, @JsonKey(name: 'template_id', fromJson: asIntOrNull)  int? templateId,  String status, @JsonKey(name: 'error_message')  String? errorMessage, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that.id,_that.conversationId,_that.direction,_that.senderType,_that.contentType,_that.body,_that.templateId,_that.status,_that.errorMessage,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: asInt)  int id, @JsonKey(name: 'conversation_id', fromJson: asInt)  int conversationId,  String direction, @JsonKey(name: 'sender_type')  String? senderType, @JsonKey(name: 'content_type')  String? contentType,  String? body, @JsonKey(name: 'template_id', fromJson: asIntOrNull)  int? templateId,  String status, @JsonKey(name: 'error_message')  String? errorMessage, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.conversationId,_that.direction,_that.senderType,_that.contentType,_that.body,_that.templateId,_that.status,_that.errorMessage,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessage extends ChatMessage {
  const _ChatMessage({@JsonKey(fromJson: asInt) required this.id, @JsonKey(name: 'conversation_id', fromJson: asInt) required this.conversationId, this.direction = 'inbound', @JsonKey(name: 'sender_type') this.senderType, @JsonKey(name: 'content_type') this.contentType, this.body, @JsonKey(name: 'template_id', fromJson: asIntOrNull) this.templateId, this.status = 'sent', @JsonKey(name: 'error_message') this.errorMessage, @JsonKey(name: 'created_at') this.createdAt}): super._();
  factory _ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

@override@JsonKey(fromJson: asInt) final  int id;
@override@JsonKey(name: 'conversation_id', fromJson: asInt) final  int conversationId;
@override@JsonKey() final  String direction;
@override@JsonKey(name: 'sender_type') final  String? senderType;
@override@JsonKey(name: 'content_type') final  String? contentType;
@override final  String? body;
@override@JsonKey(name: 'template_id', fromJson: asIntOrNull) final  int? templateId;
@override@JsonKey() final  String status;
@override@JsonKey(name: 'error_message') final  String? errorMessage;
@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.senderType, senderType) || other.senderType == senderType)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.body, body) || other.body == body)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,conversationId,direction,senderType,contentType,body,templateId,status,errorMessage,createdAt);
}

@override
String toString() {
    return 'ChatMessage(id: $id, conversationId: $conversationId, direction: $direction, senderType: $senderType, contentType: $contentType, body: $body, templateId: $templateId, status: $status, errorMessage: $errorMessage, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: asInt) int id,@JsonKey(name: 'conversation_id', fromJson: asInt) int conversationId, String direction,@JsonKey(name: 'sender_type') String? senderType,@JsonKey(name: 'content_type') String? contentType, String? body,@JsonKey(name: 'template_id', fromJson: asIntOrNull) int? templateId, String status,@JsonKey(name: 'error_message') String? errorMessage,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? direction = null,Object? senderType = freezed,Object? contentType = freezed,Object? body = freezed,Object? templateId = freezed,Object? status = null,Object? errorMessage = freezed,Object? createdAt = freezed,}) {
  return _then(_ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,senderType: freezed == senderType ? _self.senderType : senderType // ignore: cast_nullable_to_non_nullable
as String?,contentType: freezed == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MessagesPagedResponse {

 List<ChatMessage> get data; ChatPagination? get pagination;
/// Create a copy of MessagesPagedResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessagesPagedResponseCopyWith<MessagesPagedResponse> get copyWith => _$MessagesPagedResponseCopyWithImpl<MessagesPagedResponse>(this as MessagesPagedResponse, _$identity);

  /// Serializes this MessagesPagedResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MessagesPagedResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessagesPagedResponse&&const DeepCollectionEquality().equals(other.data, _this.data)&&(identical(other.pagination, _this.pagination) || other.pagination == _this.pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MessagesPagedResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.data),_this.pagination);
}

@override
String toString() {
  final _this = this as MessagesPagedResponse;
  return 'MessagesPagedResponse(data: ${_this.data}, pagination: ${_this.pagination})';
}


}

/// @nodoc
abstract mixin class $MessagesPagedResponseCopyWith<$Res>  {
  factory $MessagesPagedResponseCopyWith(MessagesPagedResponse value, $Res Function(MessagesPagedResponse) _then) = _$MessagesPagedResponseCopyWithImpl;
@useResult
$Res call({
 List<ChatMessage> data, ChatPagination? pagination
});


$ChatPaginationCopyWith<$Res>? get pagination;

}
/// @nodoc
class _$MessagesPagedResponseCopyWithImpl<$Res>
    implements $MessagesPagedResponseCopyWith<$Res> {
  _$MessagesPagedResponseCopyWithImpl(this._self, this._then);

  final MessagesPagedResponse _self;
  final $Res Function(MessagesPagedResponse) _then;

/// Create a copy of MessagesPagedResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? pagination = freezed,}) {
  return _then(MessagesPagedResponse(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ChatPagination?,
  ));
}
/// Create a copy of MessagesPagedResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatPaginationCopyWith<$Res>? get pagination {
    if (_self.pagination == null) {
    return null;
  }

  return $ChatPaginationCopyWith<$Res>(_self.pagination!, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}


/// Adds pattern-matching-related methods to [MessagesPagedResponse].
extension MessagesPagedResponsePatterns on MessagesPagedResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessagesPagedResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessagesPagedResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessagesPagedResponse value)  $default,){
final _that = this;
switch (_that) {
case _MessagesPagedResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessagesPagedResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MessagesPagedResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatMessage> data,  ChatPagination? pagination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessagesPagedResponse() when $default != null:
return $default(_that.data,_that.pagination);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatMessage> data,  ChatPagination? pagination)  $default,) {final _that = this;
switch (_that) {
case _MessagesPagedResponse():
return $default(_that.data,_that.pagination);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatMessage> data,  ChatPagination? pagination)?  $default,) {final _that = this;
switch (_that) {
case _MessagesPagedResponse() when $default != null:
return $default(_that.data,_that.pagination);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessagesPagedResponse implements MessagesPagedResponse {
  const _MessagesPagedResponse({ List<ChatMessage> data = const [], this.pagination}): _data = data;
  factory _MessagesPagedResponse.fromJson(Map<String, dynamic> json) => _$MessagesPagedResponseFromJson(json);

 final  List<ChatMessage> _data;
@override@JsonKey() List<ChatMessage> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override final  ChatPagination? pagination;

/// Create a copy of MessagesPagedResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessagesPagedResponseCopyWith<_MessagesPagedResponse> get copyWith => __$MessagesPagedResponseCopyWithImpl<_MessagesPagedResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessagesPagedResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessagesPagedResponse&&const DeepCollectionEquality().equals(other.data, _data)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),pagination);
}

@override
String toString() {
    return 'MessagesPagedResponse(data: $data, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$MessagesPagedResponseCopyWith<$Res> implements $MessagesPagedResponseCopyWith<$Res> {
  factory _$MessagesPagedResponseCopyWith(_MessagesPagedResponse value, $Res Function(_MessagesPagedResponse) _then) = __$MessagesPagedResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ChatMessage> data, ChatPagination? pagination
});


@override $ChatPaginationCopyWith<$Res>? get pagination;

}
/// @nodoc
class __$MessagesPagedResponseCopyWithImpl<$Res>
    implements _$MessagesPagedResponseCopyWith<$Res> {
  __$MessagesPagedResponseCopyWithImpl(this._self, this._then);

  final _MessagesPagedResponse _self;
  final $Res Function(_MessagesPagedResponse) _then;

/// Create a copy of MessagesPagedResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? pagination = freezed,}) {
  return _then(_MessagesPagedResponse(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ChatPagination?,
  ));
}

/// Create a copy of MessagesPagedResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatPaginationCopyWith<$Res>? get pagination {
    if (_self.pagination == null) {
    return null;
  }

  return $ChatPaginationCopyWith<$Res>(_self.pagination!, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}

// dart format on
