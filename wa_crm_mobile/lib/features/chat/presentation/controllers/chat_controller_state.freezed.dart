// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_controller_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatControllerState {

 List<ChatConversation> get conversations; bool get isLoading; bool get isLoadingMore; String? get errorMessage; String get selectedStatus; String get searchQuery; int get currentPage; int get totalPages; int get totalCount; int get unreadCount;
/// Create a copy of ChatControllerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatControllerStateCopyWith<ChatControllerState> get copyWith => _$ChatControllerStateCopyWithImpl<ChatControllerState>(this as ChatControllerState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatControllerState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatControllerState&&const DeepCollectionEquality().equals(other.conversations, _this.conversations)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage)&&(identical(other.selectedStatus, _this.selectedStatus) || other.selectedStatus == _this.selectedStatus)&&(identical(other.searchQuery, _this.searchQuery) || other.searchQuery == _this.searchQuery)&&(identical(other.currentPage, _this.currentPage) || other.currentPage == _this.currentPage)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.unreadCount, _this.unreadCount) || other.unreadCount == _this.unreadCount));
}


@override
int get hashCode {
  final _this = this as ChatControllerState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.conversations),_this.isLoading,_this.isLoadingMore,_this.errorMessage,_this.selectedStatus,_this.searchQuery,_this.currentPage,_this.totalPages,_this.totalCount,_this.unreadCount);
}

@override
String toString() {
  final _this = this as ChatControllerState;
  return 'ChatControllerState(conversations: ${_this.conversations}, isLoading: ${_this.isLoading}, isLoadingMore: ${_this.isLoadingMore}, errorMessage: ${_this.errorMessage}, selectedStatus: ${_this.selectedStatus}, searchQuery: ${_this.searchQuery}, currentPage: ${_this.currentPage}, totalPages: ${_this.totalPages}, totalCount: ${_this.totalCount}, unreadCount: ${_this.unreadCount})';
}


}

/// @nodoc
abstract mixin class $ChatControllerStateCopyWith<$Res>  {
  factory $ChatControllerStateCopyWith(ChatControllerState value, $Res Function(ChatControllerState) _then) = _$ChatControllerStateCopyWithImpl;
@useResult
$Res call({
 List<ChatConversation> conversations, bool isLoading, bool isLoadingMore, String? errorMessage, String selectedStatus, String searchQuery, int currentPage, int totalPages, int totalCount, int unreadCount
});




}
/// @nodoc
class _$ChatControllerStateCopyWithImpl<$Res>
    implements $ChatControllerStateCopyWith<$Res> {
  _$ChatControllerStateCopyWithImpl(this._self, this._then);

  final ChatControllerState _self;
  final $Res Function(ChatControllerState) _then;

/// Create a copy of ChatControllerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversations = null,Object? isLoading = null,Object? isLoadingMore = null,Object? errorMessage = freezed,Object? selectedStatus = null,Object? searchQuery = null,Object? currentPage = null,Object? totalPages = null,Object? totalCount = null,Object? unreadCount = null,}) {
  return _then(ChatControllerState(
conversations: null == conversations ? _self.conversations : conversations // ignore: cast_nullable_to_non_nullable
as List<ChatConversation>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatControllerState].
extension ChatControllerStatePatterns on ChatControllerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatControllerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatControllerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatControllerState value)  $default,){
final _that = this;
switch (_that) {
case _ChatControllerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatControllerState value)?  $default,){
final _that = this;
switch (_that) {
case _ChatControllerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatConversation> conversations,  bool isLoading,  bool isLoadingMore,  String? errorMessage,  String selectedStatus,  String searchQuery,  int currentPage,  int totalPages,  int totalCount,  int unreadCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatControllerState() when $default != null:
return $default(_that.conversations,_that.isLoading,_that.isLoadingMore,_that.errorMessage,_that.selectedStatus,_that.searchQuery,_that.currentPage,_that.totalPages,_that.totalCount,_that.unreadCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatConversation> conversations,  bool isLoading,  bool isLoadingMore,  String? errorMessage,  String selectedStatus,  String searchQuery,  int currentPage,  int totalPages,  int totalCount,  int unreadCount)  $default,) {final _that = this;
switch (_that) {
case _ChatControllerState():
return $default(_that.conversations,_that.isLoading,_that.isLoadingMore,_that.errorMessage,_that.selectedStatus,_that.searchQuery,_that.currentPage,_that.totalPages,_that.totalCount,_that.unreadCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatConversation> conversations,  bool isLoading,  bool isLoadingMore,  String? errorMessage,  String selectedStatus,  String searchQuery,  int currentPage,  int totalPages,  int totalCount,  int unreadCount)?  $default,) {final _that = this;
switch (_that) {
case _ChatControllerState() when $default != null:
return $default(_that.conversations,_that.isLoading,_that.isLoadingMore,_that.errorMessage,_that.selectedStatus,_that.searchQuery,_that.currentPage,_that.totalPages,_that.totalCount,_that.unreadCount);case _:
  return null;

}
}

}

/// @nodoc


class _ChatControllerState implements ChatControllerState {
  const _ChatControllerState({ List<ChatConversation> conversations = const [], this.isLoading = true, this.isLoadingMore = false, this.errorMessage, this.selectedStatus = 'all', this.searchQuery = '', this.currentPage = 1, this.totalPages = 1, this.totalCount = 0, this.unreadCount = 0}): _conversations = conversations;
  

 final  List<ChatConversation> _conversations;
@override@JsonKey() List<ChatConversation> get conversations {
  if (_conversations is EqualUnmodifiableListView) return _conversations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conversations);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override final  String? errorMessage;
@override@JsonKey() final  String selectedStatus;
@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  int unreadCount;

/// Create a copy of ChatControllerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatControllerStateCopyWith<_ChatControllerState> get copyWith => __$ChatControllerStateCopyWithImpl<_ChatControllerState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatControllerState&&const DeepCollectionEquality().equals(other.conversations, _conversations)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_conversations),isLoading,isLoadingMore,errorMessage,selectedStatus,searchQuery,currentPage,totalPages,totalCount,unreadCount);
}

@override
String toString() {
    return 'ChatControllerState(conversations: $conversations, isLoading: $isLoading, isLoadingMore: $isLoadingMore, errorMessage: $errorMessage, selectedStatus: $selectedStatus, searchQuery: $searchQuery, currentPage: $currentPage, totalPages: $totalPages, totalCount: $totalCount, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class _$ChatControllerStateCopyWith<$Res> implements $ChatControllerStateCopyWith<$Res> {
  factory _$ChatControllerStateCopyWith(_ChatControllerState value, $Res Function(_ChatControllerState) _then) = __$ChatControllerStateCopyWithImpl;
@override @useResult
$Res call({
 List<ChatConversation> conversations, bool isLoading, bool isLoadingMore, String? errorMessage, String selectedStatus, String searchQuery, int currentPage, int totalPages, int totalCount, int unreadCount
});




}
/// @nodoc
class __$ChatControllerStateCopyWithImpl<$Res>
    implements _$ChatControllerStateCopyWith<$Res> {
  __$ChatControllerStateCopyWithImpl(this._self, this._then);

  final _ChatControllerState _self;
  final $Res Function(_ChatControllerState) _then;

/// Create a copy of ChatControllerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversations = null,Object? isLoading = null,Object? isLoadingMore = null,Object? errorMessage = freezed,Object? selectedStatus = null,Object? searchQuery = null,Object? currentPage = null,Object? totalPages = null,Object? totalCount = null,Object? unreadCount = null,}) {
  return _then(_ChatControllerState(
conversations: null == conversations ? _self._conversations : conversations // ignore: cast_nullable_to_non_nullable
as List<ChatConversation>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
