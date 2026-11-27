// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => _ChatMessage(
  id: asInt(json['id']),
  conversationId: asInt(json['conversation_id']),
  direction: json['direction'] as String? ?? 'inbound',
  senderType: json['sender_type'] as String?,
  contentType: json['content_type'] as String?,
  body: json['body'] as String?,
  templateId: asIntOrNull(json['template_id']),
  status: json['status'] as String? ?? 'sent',
  errorMessage: json['error_message'] as String?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$ChatMessageToJson(_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversation_id': instance.conversationId,
      'direction': instance.direction,
      'sender_type': instance.senderType,
      'content_type': instance.contentType,
      'body': instance.body,
      'template_id': instance.templateId,
      'status': instance.status,
      'error_message': instance.errorMessage,
      'created_at': instance.createdAt,
    };

_MessagesPagedResponse _$MessagesPagedResponseFromJson(
  Map<String, dynamic> json,
) => _MessagesPagedResponse(
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pagination: json['pagination'] == null
      ? null
      : ChatPagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MessagesPagedResponseToJson(
  _MessagesPagedResponse instance,
) => <String, dynamic>{
  'data': instance.data,
  'pagination': instance.pagination,
};
