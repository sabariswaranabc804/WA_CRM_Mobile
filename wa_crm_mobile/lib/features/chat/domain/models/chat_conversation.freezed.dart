// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatConversation {

@JsonKey(fromJson: asInt) int get id;@JsonKey(name: 'contact_id', fromJson: asInt) int get contactId; String get channel; String get status;@JsonKey(name: 'assigned_to', fromJson: asIntOrNull) int? get assignedTo;@JsonKey(name: 'assigned_to_name') String? get assignedToName;@JsonKey(name: 'last_message_at') String? get lastMessageAt;@JsonKey(name: 'unread_count', fromJson: asInt) int get unreadCount;@JsonKey(name: 'within_session_window', fromJson: asBool) bool get withinSessionWindow;@JsonKey(name: 'contact_name') String? get contactName;@JsonKey(name: 'contact_phone') String? get contactPhone;@JsonKey(name: 'contact_email') String? get contactEmail;@JsonKey(name: 'contact_instagram_handle') String? get contactInstagramHandle;@JsonKey(name: 'last_message_body') String? get lastMessageBody;@JsonKey(name: 'last_message_content_type') String? get lastMessageContentType;@JsonKey(name: 'last_message_direction') String? get lastMessageDirection;
/// Create a copy of ChatConversation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatConversationCopyWith<ChatConversation> get copyWith => _$ChatConversationCopyWithImpl<ChatConversation>(this as ChatConversation, _$identity);

  /// Serializes this ChatConversation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatConversation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatConversation&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.contactId, _this.contactId) || other.contactId == _this.contactId)&&(identical(other.channel, _this.channel) || other.channel == _this.channel)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.assignedTo, _this.assignedTo) || other.assignedTo == _this.assignedTo)&&(identical(other.assignedToName, _this.assignedToName) || other.assignedToName == _this.assignedToName)&&(identical(other.lastMessageAt, _this.lastMessageAt) || other.lastMessageAt == _this.lastMessageAt)&&(identical(other.unreadCount, _this.unreadCount) || other.unreadCount == _this.unreadCount)&&(identical(other.withinSessionWindow, _this.withinSessionWindow) || other.withinSessionWindow == _this.withinSessionWindow)&&(identical(other.contactName, _this.contactName) || other.contactName == _this.contactName)&&(identical(other.contactPhone, _this.contactPhone) || other.contactPhone == _this.contactPhone)&&(identical(other.contactEmail, _this.contactEmail) || other.contactEmail == _this.contactEmail)&&(identical(other.contactInstagramHandle, _this.contactInstagramHandle) || other.contactInstagramHandle == _this.contactInstagramHandle)&&(identical(other.lastMessageBody, _this.lastMessageBody) || other.lastMessageBody == _this.lastMessageBody)&&(identical(other.lastMessageContentType, _this.lastMessageContentType) || other.lastMessageContentType == _this.lastMessageContentType)&&(identical(other.lastMessageDirection, _this.lastMessageDirection) || other.lastMessageDirection == _this.lastMessageDirection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatConversation;
  return Object.hash(runtimeType,_this.id,_this.contactId,_this.channel,_this.status,_this.assignedTo,_this.assignedToName,_this.lastMessageAt,_this.unreadCount,_this.withinSessionWindow,_this.contactName,_this.contactPhone,_this.contactEmail,_this.contactInstagramHandle,_this.lastMessageBody,_this.lastMessageContentType,_this.lastMessageDirection);
}

@override
String toString() {
  final _this = this as ChatConversation;
  return 'ChatConversation(id: ${_this.id}, contactId: ${_this.contactId}, channel: ${_this.channel}, status: ${_this.status}, assignedTo: ${_this.assignedTo}, assignedToName: ${_this.assignedToName}, lastMessageAt: ${_this.lastMessageAt}, unreadCount: ${_this.unreadCount}, withinSessionWindow: ${_this.withinSessionWindow}, contactName: ${_this.contactName}, contactPhone: ${_this.contactPhone}, contactEmail: ${_this.contactEmail}, contactInstagramHandle: ${_this.contactInstagramHandle}, lastMessageBody: ${_this.lastMessageBody}, lastMessageContentType: ${_this.lastMessageContentType}, lastMessageDirection: ${_this.lastMessageDirection})';
}


}

/// @nodoc
abstract mixin class $ChatConversationCopyWith<$Res>  {
  factory $ChatConversationCopyWith(ChatConversation value, $Res Function(ChatConversation) _then) = _$ChatConversationCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: asInt) int id,@JsonKey(name: 'contact_id', fromJson: asInt) int contactId, String channel, String status,@JsonKey(name: 'assigned_to', fromJson: asIntOrNull) int? assignedTo,@JsonKey(name: 'assigned_to_name') String? assignedToName,@JsonKey(name: 'last_message_at') String? lastMessageAt,@JsonKey(name: 'unread_count', fromJson: asInt) int unreadCount,@JsonKey(name: 'within_session_window', fromJson: asBool) bool withinSessionWindow,@JsonKey(name: 'contact_name') String? contactName,@JsonKey(name: 'contact_phone') String? contactPhone,@JsonKey(name: 'contact_email') String? contactEmail,@JsonKey(name: 'contact_instagram_handle') String? contactInstagramHandle,@JsonKey(name: 'last_message_body') String? lastMessageBody,@JsonKey(name: 'last_message_content_type') String? lastMessageContentType,@JsonKey(name: 'last_message_direction') String? lastMessageDirection
});




}
/// @nodoc
class _$ChatConversationCopyWithImpl<$Res>
    implements $ChatConversationCopyWith<$Res> {
  _$ChatConversationCopyWithImpl(this._self, this._then);

  final ChatConversation _self;
  final $Res Function(ChatConversation) _then;

/// Create a copy of ChatConversation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? contactId = null,Object? channel = null,Object? status = null,Object? assignedTo = freezed,Object? assignedToName = freezed,Object? lastMessageAt = freezed,Object? unreadCount = null,Object? withinSessionWindow = null,Object? contactName = freezed,Object? contactPhone = freezed,Object? contactEmail = freezed,Object? contactInstagramHandle = freezed,Object? lastMessageBody = freezed,Object? lastMessageContentType = freezed,Object? lastMessageDirection = freezed,}) {
  return _then(ChatConversation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,contactId: null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as int,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as int?,assignedToName: freezed == assignedToName ? _self.assignedToName : assignedToName // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as String?,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,withinSessionWindow: null == withinSessionWindow ? _self.withinSessionWindow : withinSessionWindow // ignore: cast_nullable_to_non_nullable
as bool,contactName: freezed == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,contactEmail: freezed == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String?,contactInstagramHandle: freezed == contactInstagramHandle ? _self.contactInstagramHandle : contactInstagramHandle // ignore: cast_nullable_to_non_nullable
as String?,lastMessageBody: freezed == lastMessageBody ? _self.lastMessageBody : lastMessageBody // ignore: cast_nullable_to_non_nullable
as String?,lastMessageContentType: freezed == lastMessageContentType ? _self.lastMessageContentType : lastMessageContentType // ignore: cast_nullable_to_non_nullable
as String?,lastMessageDirection: freezed == lastMessageDirection ? _self.lastMessageDirection : lastMessageDirection // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatConversation].
extension ChatConversationPatterns on ChatConversation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatConversation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatConversation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatConversation value)  $default,){
final _that = this;
switch (_that) {
case _ChatConversation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatConversation value)?  $default,){
final _that = this;
switch (_that) {
case _ChatConversation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: asInt)  int id, @JsonKey(name: 'contact_id', fromJson: asInt)  int contactId,  String channel,  String status, @JsonKey(name: 'assigned_to', fromJson: asIntOrNull)  int? assignedTo, @JsonKey(name: 'assigned_to_name')  String? assignedToName, @JsonKey(name: 'last_message_at')  String? lastMessageAt, @JsonKey(name: 'unread_count', fromJson: asInt)  int unreadCount, @JsonKey(name: 'within_session_window', fromJson: asBool)  bool withinSessionWindow, @JsonKey(name: 'contact_name')  String? contactName, @JsonKey(name: 'contact_phone')  String? contactPhone, @JsonKey(name: 'contact_email')  String? contactEmail, @JsonKey(name: 'contact_instagram_handle')  String? contactInstagramHandle, @JsonKey(name: 'last_message_body')  String? lastMessageBody, @JsonKey(name: 'last_message_content_type')  String? lastMessageContentType, @JsonKey(name: 'last_message_direction')  String? lastMessageDirection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatConversation() when $default != null:
return $default(_that.id,_that.contactId,_that.channel,_that.status,_that.assignedTo,_that.assignedToName,_that.lastMessageAt,_that.unreadCount,_that.withinSessionWindow,_that.contactName,_that.contactPhone,_that.contactEmail,_that.contactInstagramHandle,_that.lastMessageBody,_that.lastMessageContentType,_that.lastMessageDirection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: asInt)  int id, @JsonKey(name: 'contact_id', fromJson: asInt)  int contactId,  String channel,  String status, @JsonKey(name: 'assigned_to', fromJson: asIntOrNull)  int? assignedTo, @JsonKey(name: 'assigned_to_name')  String? assignedToName, @JsonKey(name: 'last_message_at')  String? lastMessageAt, @JsonKey(name: 'unread_count', fromJson: asInt)  int unreadCount, @JsonKey(name: 'within_session_window', fromJson: asBool)  bool withinSessionWindow, @JsonKey(name: 'contact_name')  String? contactName, @JsonKey(name: 'contact_phone')  String? contactPhone, @JsonKey(name: 'contact_email')  String? contactEmail, @JsonKey(name: 'contact_instagram_handle')  String? contactInstagramHandle, @JsonKey(name: 'last_message_body')  String? lastMessageBody, @JsonKey(name: 'last_message_content_type')  String? lastMessageContentType, @JsonKey(name: 'last_message_direction')  String? lastMessageDirection)  $default,) {final _that = this;
switch (_that) {
case _ChatConversation():
return $default(_that.id,_that.contactId,_that.channel,_that.status,_that.assignedTo,_that.assignedToName,_that.lastMessageAt,_that.unreadCount,_that.withinSessionWindow,_that.contactName,_that.contactPhone,_that.contactEmail,_that.contactInstagramHandle,_that.lastMessageBody,_that.lastMessageContentType,_that.lastMessageDirection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: asInt)  int id, @JsonKey(name: 'contact_id', fromJson: asInt)  int contactId,  String channel,  String status, @JsonKey(name: 'assigned_to', fromJson: asIntOrNull)  int? assignedTo, @JsonKey(name: 'assigned_to_name')  String? assignedToName, @JsonKey(name: 'last_message_at')  String? lastMessageAt, @JsonKey(name: 'unread_count', fromJson: asInt)  int unreadCount, @JsonKey(name: 'within_session_window', fromJson: asBool)  bool withinSessionWindow, @JsonKey(name: 'contact_name')  String? contactName, @JsonKey(name: 'contact_phone')  String? contactPhone, @JsonKey(name: 'contact_email')  String? contactEmail, @JsonKey(name: 'contact_instagram_handle')  String? contactInstagramHandle, @JsonKey(name: 'last_message_body')  String? lastMessageBody, @JsonKey(name: 'last_message_content_type')  String? lastMessageContentType, @JsonKey(name: 'last_message_direction')  String? lastMessageDirection)?  $default,) {final _that = this;
switch (_that) {
case _ChatConversation() when $default != null:
return $default(_that.id,_that.contactId,_that.channel,_that.status,_that.assignedTo,_that.assignedToName,_that.lastMessageAt,_that.unreadCount,_that.withinSessionWindow,_that.contactName,_that.contactPhone,_that.contactEmail,_that.contactInstagramHandle,_that.lastMessageBody,_that.lastMessageContentType,_that.lastMessageDirection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatConversation extends ChatConversation {
  const _ChatConversation({@JsonKey(fromJson: asInt) required this.id, @JsonKey(name: 'contact_id', fromJson: asInt) required this.contactId, this.channel = 'whatsapp', this.status = 'open', @JsonKey(name: 'assigned_to', fromJson: asIntOrNull) this.assignedTo, @JsonKey(name: 'assigned_to_name') this.assignedToName, @JsonKey(name: 'last_message_at') this.lastMessageAt, @JsonKey(name: 'unread_count', fromJson: asInt) this.unreadCount = 0, @JsonKey(name: 'within_session_window', fromJson: asBool) this.withinSessionWindow = true, @JsonKey(name: 'contact_name') this.contactName, @JsonKey(name: 'contact_phone') this.contactPhone, @JsonKey(name: 'contact_email') this.contactEmail, @JsonKey(name: 'contact_instagram_handle') this.contactInstagramHandle, @JsonKey(name: 'last_message_body') this.lastMessageBody, @JsonKey(name: 'last_message_content_type') this.lastMessageContentType, @JsonKey(name: 'last_message_direction') this.lastMessageDirection}): super._();
  factory _ChatConversation.fromJson(Map<String, dynamic> json) => _$ChatConversationFromJson(json);

@override@JsonKey(fromJson: asInt) final  int id;
@override@JsonKey(name: 'contact_id', fromJson: asInt) final  int contactId;
@override@JsonKey() final  String channel;
@override@JsonKey() final  String status;
@override@JsonKey(name: 'assigned_to', fromJson: asIntOrNull) final  int? assignedTo;
@override@JsonKey(name: 'assigned_to_name') final  String? assignedToName;
@override@JsonKey(name: 'last_message_at') final  String? lastMessageAt;
@override@JsonKey(name: 'unread_count', fromJson: asInt) final  int unreadCount;
@override@JsonKey(name: 'within_session_window', fromJson: asBool) final  bool withinSessionWindow;
@override@JsonKey(name: 'contact_name') final  String? contactName;
@override@JsonKey(name: 'contact_phone') final  String? contactPhone;
@override@JsonKey(name: 'contact_email') final  String? contactEmail;
@override@JsonKey(name: 'contact_instagram_handle') final  String? contactInstagramHandle;
@override@JsonKey(name: 'last_message_body') final  String? lastMessageBody;
@override@JsonKey(name: 'last_message_content_type') final  String? lastMessageContentType;
@override@JsonKey(name: 'last_message_direction') final  String? lastMessageDirection;

/// Create a copy of ChatConversation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatConversationCopyWith<_ChatConversation> get copyWith => __$ChatConversationCopyWithImpl<_ChatConversation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatConversationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatConversation&&(identical(other.id, id) || other.id == id)&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.status, status) || other.status == status)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo)&&(identical(other.assignedToName, assignedToName) || other.assignedToName == assignedToName)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.withinSessionWindow, withinSessionWindow) || other.withinSessionWindow == withinSessionWindow)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.contactInstagramHandle, contactInstagramHandle) || other.contactInstagramHandle == contactInstagramHandle)&&(identical(other.lastMessageBody, lastMessageBody) || other.lastMessageBody == lastMessageBody)&&(identical(other.lastMessageContentType, lastMessageContentType) || other.lastMessageContentType == lastMessageContentType)&&(identical(other.lastMessageDirection, lastMessageDirection) || other.lastMessageDirection == lastMessageDirection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,contactId,channel,status,assignedTo,assignedToName,lastMessageAt,unreadCount,withinSessionWindow,contactName,contactPhone,contactEmail,contactInstagramHandle,lastMessageBody,lastMessageContentType,lastMessageDirection);
}

@override
String toString() {
    return 'ChatConversation(id: $id, contactId: $contactId, channel: $channel, status: $status, assignedTo: $assignedTo, assignedToName: $assignedToName, lastMessageAt: $lastMessageAt, unreadCount: $unreadCount, withinSessionWindow: $withinSessionWindow, contactName: $contactName, contactPhone: $contactPhone, contactEmail: $contactEmail, contactInstagramHandle: $contactInstagramHandle, lastMessageBody: $lastMessageBody, lastMessageContentType: $lastMessageContentType, lastMessageDirection: $lastMessageDirection)';
}


}

/// @nodoc
abstract mixin class _$ChatConversationCopyWith<$Res> implements $ChatConversationCopyWith<$Res> {
  factory _$ChatConversationCopyWith(_ChatConversation value, $Res Function(_ChatConversation) _then) = __$ChatConversationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: asInt) int id,@JsonKey(name: 'contact_id', fromJson: asInt) int contactId, String channel, String status,@JsonKey(name: 'assigned_to', fromJson: asIntOrNull) int? assignedTo,@JsonKey(name: 'assigned_to_name') String? assignedToName,@JsonKey(name: 'last_message_at') String? lastMessageAt,@JsonKey(name: 'unread_count', fromJson: asInt) int unreadCount,@JsonKey(name: 'within_session_window', fromJson: asBool) bool withinSessionWindow,@JsonKey(name: 'contact_name') String? contactName,@JsonKey(name: 'contact_phone') String? contactPhone,@JsonKey(name: 'contact_email') String? contactEmail,@JsonKey(name: 'contact_instagram_handle') String? contactInstagramHandle,@JsonKey(name: 'last_message_body') String? lastMessageBody,@JsonKey(name: 'last_message_content_type') String? lastMessageContentType,@JsonKey(name: 'last_message_direction') String? lastMessageDirection
});




}
/// @nodoc
class __$ChatConversationCopyWithImpl<$Res>
    implements _$ChatConversationCopyWith<$Res> {
  __$ChatConversationCopyWithImpl(this._self, this._then);

  final _ChatConversation _self;
  final $Res Function(_ChatConversation) _then;

/// Create a copy of ChatConversation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? contactId = null,Object? channel = null,Object? status = null,Object? assignedTo = freezed,Object? assignedToName = freezed,Object? lastMessageAt = freezed,Object? unreadCount = null,Object? withinSessionWindow = null,Object? contactName = freezed,Object? contactPhone = freezed,Object? contactEmail = freezed,Object? contactInstagramHandle = freezed,Object? lastMessageBody = freezed,Object? lastMessageContentType = freezed,Object? lastMessageDirection = freezed,}) {
  return _then(_ChatConversation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,contactId: null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as int,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as int?,assignedToName: freezed == assignedToName ? _self.assignedToName : assignedToName // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as String?,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,withinSessionWindow: null == withinSessionWindow ? _self.withinSessionWindow : withinSessionWindow // ignore: cast_nullable_to_non_nullable
as bool,contactName: freezed == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,contactEmail: freezed == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String?,contactInstagramHandle: freezed == contactInstagramHandle ? _self.contactInstagramHandle : contactInstagramHandle // ignore: cast_nullable_to_non_nullable
as String?,lastMessageBody: freezed == lastMessageBody ? _self.lastMessageBody : lastMessageBody // ignore: cast_nullable_to_non_nullable
as String?,lastMessageContentType: freezed == lastMessageContentType ? _self.lastMessageContentType : lastMessageContentType // ignore: cast_nullable_to_non_nullable
as String?,lastMessageDirection: freezed == lastMessageDirection ? _self.lastMessageDirection : lastMessageDirection // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ConversationsPagedResponse {

 List<ChatConversation> get data; ChatPagination? get pagination;
/// Create a copy of ConversationsPagedResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationsPagedResponseCopyWith<ConversationsPagedResponse> get copyWith => _$ConversationsPagedResponseCopyWithImpl<ConversationsPagedResponse>(this as ConversationsPagedResponse, _$identity);

  /// Serializes this ConversationsPagedResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ConversationsPagedResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationsPagedResponse&&const DeepCollectionEquality().equals(other.data, _this.data)&&(identical(other.pagination, _this.pagination) || other.pagination == _this.pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ConversationsPagedResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.data),_this.pagination);
}

@override
String toString() {
  final _this = this as ConversationsPagedResponse;
  return 'ConversationsPagedResponse(data: ${_this.data}, pagination: ${_this.pagination})';
}


}

/// @nodoc
abstract mixin class $ConversationsPagedResponseCopyWith<$Res>  {
  factory $ConversationsPagedResponseCopyWith(ConversationsPagedResponse value, $Res Function(ConversationsPagedResponse) _then) = _$ConversationsPagedResponseCopyWithImpl;
@useResult
$Res call({
 List<ChatConversation> data, ChatPagination? pagination
});


$ChatPaginationCopyWith<$Res>? get pagination;

}
/// @nodoc
class _$ConversationsPagedResponseCopyWithImpl<$Res>
    implements $ConversationsPagedResponseCopyWith<$Res> {
  _$ConversationsPagedResponseCopyWithImpl(this._self, this._then);

  final ConversationsPagedResponse _self;
  final $Res Function(ConversationsPagedResponse) _then;

/// Create a copy of ConversationsPagedResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? pagination = freezed,}) {
  return _then(ConversationsPagedResponse(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<ChatConversation>,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ChatPagination?,
  ));
}
/// Create a copy of ConversationsPagedResponse
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


/// Adds pattern-matching-related methods to [ConversationsPagedResponse].
extension ConversationsPagedResponsePatterns on ConversationsPagedResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationsPagedResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationsPagedResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationsPagedResponse value)  $default,){
final _that = this;
switch (_that) {
case _ConversationsPagedResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationsPagedResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationsPagedResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatConversation> data,  ChatPagination? pagination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationsPagedResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatConversation> data,  ChatPagination? pagination)  $default,) {final _that = this;
switch (_that) {
case _ConversationsPagedResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatConversation> data,  ChatPagination? pagination)?  $default,) {final _that = this;
switch (_that) {
case _ConversationsPagedResponse() when $default != null:
return $default(_that.data,_that.pagination);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConversationsPagedResponse implements ConversationsPagedResponse {
  const _ConversationsPagedResponse({ List<ChatConversation> data = const [], this.pagination}): _data = data;
  factory _ConversationsPagedResponse.fromJson(Map<String, dynamic> json) => _$ConversationsPagedResponseFromJson(json);

 final  List<ChatConversation> _data;
@override@JsonKey() List<ChatConversation> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override final  ChatPagination? pagination;

/// Create a copy of ConversationsPagedResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationsPagedResponseCopyWith<_ConversationsPagedResponse> get copyWith => __$ConversationsPagedResponseCopyWithImpl<_ConversationsPagedResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversationsPagedResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationsPagedResponse&&const DeepCollectionEquality().equals(other.data, _data)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),pagination);
}

@override
String toString() {
    return 'ConversationsPagedResponse(data: $data, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$ConversationsPagedResponseCopyWith<$Res> implements $ConversationsPagedResponseCopyWith<$Res> {
  factory _$ConversationsPagedResponseCopyWith(_ConversationsPagedResponse value, $Res Function(_ConversationsPagedResponse) _then) = __$ConversationsPagedResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ChatConversation> data, ChatPagination? pagination
});


@override $ChatPaginationCopyWith<$Res>? get pagination;

}
/// @nodoc
class __$ConversationsPagedResponseCopyWithImpl<$Res>
    implements _$ConversationsPagedResponseCopyWith<$Res> {
  __$ConversationsPagedResponseCopyWithImpl(this._self, this._then);

  final _ConversationsPagedResponse _self;
  final $Res Function(_ConversationsPagedResponse) _then;

/// Create a copy of ConversationsPagedResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? pagination = freezed,}) {
  return _then(_ConversationsPagedResponse(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<ChatConversation>,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as ChatPagination?,
  ));
}

/// Create a copy of ConversationsPagedResponse
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
