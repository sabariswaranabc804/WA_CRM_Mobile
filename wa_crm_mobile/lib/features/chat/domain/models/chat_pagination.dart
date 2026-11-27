import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wa_crm_mobile/core/utils/json_utils.dart';

part 'chat_pagination.freezed.dart';
part 'chat_pagination.g.dart';

@freezed
abstract class ChatPagination with _$ChatPagination {
  const factory ChatPagination({
    @JsonKey(fromJson: asInt) @Default(1) int page,
    @JsonKey(fromJson: asInt) @Default(1) int totalPages,
    @JsonKey(fromJson: asInt) @Default(0) int total,
    @JsonKey(fromJson: asInt) @Default(30) int limit,
  }) = _ChatPagination;

  factory ChatPagination.fromJson(Map<String, dynamic> json) =>
      _$ChatPaginationFromJson(json);
}
