import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_params.freezed.dart';
part 'chat_params.g.dart';

@freezed
abstract class ListConversationsParams with _$ListConversationsParams {
  const factory ListConversationsParams({
    @Default('all') String status,
    @Default('whatsapp') String channel,
    String? search,
    @Default(1) int page,
    @Default(30) int limit,
  }) = _ListConversationsParams;

  factory ListConversationsParams.fromJson(Map<String, dynamic> json) =>
      _$ListConversationsParamsFromJson(json);
}

@freezed
abstract class ListMessagesParams with _$ListMessagesParams {
  const factory ListMessagesParams({
    required int conversationId,
    @Default(1) int page,
    @Default(50) int limit,
  }) = _ListMessagesParams;

  factory ListMessagesParams.fromJson(Map<String, dynamic> json) =>
      _$ListMessagesParamsFromJson(json);
}

@freezed
abstract class SendReplyParams with _$SendReplyParams {
  const factory SendReplyParams({
    required int conversationId,
    String? body,
    @JsonKey(name: 'template_id') int? templateId,
  }) = _SendReplyParams;

  factory SendReplyParams.fromJson(Map<String, dynamic> json) =>
      _$SendReplyParamsFromJson(json);
}
