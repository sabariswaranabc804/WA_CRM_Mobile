// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_pagination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatPagination {

@JsonKey(fromJson: asInt) int get page;@JsonKey(fromJson: asInt) int get totalPages;@JsonKey(fromJson: asInt) int get total;@JsonKey(fromJson: asInt) int get limit;
/// Create a copy of ChatPagination
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatPaginationCopyWith<ChatPagination> get copyWith => _$ChatPaginationCopyWithImpl<ChatPagination>(this as ChatPagination, _$identity);

  /// Serializes this ChatPagination to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatPagination;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatPagination&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.limit, _this.limit) || other.limit == _this.limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatPagination;
  return Object.hash(runtimeType,_this.page,_this.totalPages,_this.total,_this.limit);
}

@override
String toString() {
  final _this = this as ChatPagination;
  return 'ChatPagination(page: ${_this.page}, totalPages: ${_this.totalPages}, total: ${_this.total}, limit: ${_this.limit})';
}


}

/// @nodoc
abstract mixin class $ChatPaginationCopyWith<$Res>  {
  factory $ChatPaginationCopyWith(ChatPagination value, $Res Function(ChatPagination) _then) = _$ChatPaginationCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: asInt) int page,@JsonKey(fromJson: asInt) int totalPages,@JsonKey(fromJson: asInt) int total,@JsonKey(fromJson: asInt) int limit
});




}
/// @nodoc
class _$ChatPaginationCopyWithImpl<$Res>
    implements $ChatPaginationCopyWith<$Res> {
  _$ChatPaginationCopyWithImpl(this._self, this._then);

  final ChatPagination _self;
  final $Res Function(ChatPagination) _then;

/// Create a copy of ChatPagination
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? totalPages = null,Object? total = null,Object? limit = null,}) {
  return _then(ChatPagination(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatPagination].
extension ChatPaginationPatterns on ChatPagination {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatPagination value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatPagination() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatPagination value)  $default,){
final _that = this;
switch (_that) {
case _ChatPagination():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatPagination value)?  $default,){
final _that = this;
switch (_that) {
case _ChatPagination() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: asInt)  int page, @JsonKey(fromJson: asInt)  int totalPages, @JsonKey(fromJson: asInt)  int total, @JsonKey(fromJson: asInt)  int limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatPagination() when $default != null:
return $default(_that.page,_that.totalPages,_that.total,_that.limit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: asInt)  int page, @JsonKey(fromJson: asInt)  int totalPages, @JsonKey(fromJson: asInt)  int total, @JsonKey(fromJson: asInt)  int limit)  $default,) {final _that = this;
switch (_that) {
case _ChatPagination():
return $default(_that.page,_that.totalPages,_that.total,_that.limit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: asInt)  int page, @JsonKey(fromJson: asInt)  int totalPages, @JsonKey(fromJson: asInt)  int total, @JsonKey(fromJson: asInt)  int limit)?  $default,) {final _that = this;
switch (_that) {
case _ChatPagination() when $default != null:
return $default(_that.page,_that.totalPages,_that.total,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatPagination implements ChatPagination {
  const _ChatPagination({@JsonKey(fromJson: asInt) this.page = 1, @JsonKey(fromJson: asInt) this.totalPages = 1, @JsonKey(fromJson: asInt) this.total = 0, @JsonKey(fromJson: asInt) this.limit = 30});
  factory _ChatPagination.fromJson(Map<String, dynamic> json) => _$ChatPaginationFromJson(json);

@override@JsonKey(fromJson: asInt) final  int page;
@override@JsonKey(fromJson: asInt) final  int totalPages;
@override@JsonKey(fromJson: asInt) final  int total;
@override@JsonKey(fromJson: asInt) final  int limit;

/// Create a copy of ChatPagination
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatPaginationCopyWith<_ChatPagination> get copyWith => __$ChatPaginationCopyWithImpl<_ChatPagination>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatPaginationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatPagination&&(identical(other.page, page) || other.page == page)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.total, total) || other.total == total)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,page,totalPages,total,limit);
}

@override
String toString() {
    return 'ChatPagination(page: $page, totalPages: $totalPages, total: $total, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$ChatPaginationCopyWith<$Res> implements $ChatPaginationCopyWith<$Res> {
  factory _$ChatPaginationCopyWith(_ChatPagination value, $Res Function(_ChatPagination) _then) = __$ChatPaginationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: asInt) int page,@JsonKey(fromJson: asInt) int totalPages,@JsonKey(fromJson: asInt) int total,@JsonKey(fromJson: asInt) int limit
});




}
/// @nodoc
class __$ChatPaginationCopyWithImpl<$Res>
    implements _$ChatPaginationCopyWith<$Res> {
  __$ChatPaginationCopyWithImpl(this._self, this._then);

  final _ChatPagination _self;
  final $Res Function(_ChatPagination) _then;

/// Create a copy of ChatPagination
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? totalPages = null,Object? total = null,Object? limit = null,}) {
  return _then(_ChatPagination(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
