// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListConversationsParams _$ListConversationsParamsFromJson(
  Map<String, dynamic> json,
) => _ListConversationsParams(
  status: json['status'] as String? ?? 'all',
  channel: json['channel'] as String? ?? 'whatsapp',
  search: json['search'] as String?,
  page: (json['page'] as num?)?.toInt() ?? 1,
  limit: (json['limit'] as num?)?.toInt() ?? 30,
);

Map<String, dynamic> _$ListConversationsParamsToJson(
  _ListConversationsParams instance,
) => <String, dynamic>{
  'status': instance.status,
  'channel': instance.channel,
  'search': instance.search,
  'page': instance.page,
  'limit': instance.limit,
};

_ListMessagesParams _$ListMessagesParamsFromJson(Map<String, dynamic> json) =>
    _ListMessagesParams(
      conversationId: (json['conversationId'] as num).toInt(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 50,
    );

Map<String, dynamic> _$ListMessagesParamsToJson(_ListMessagesParams instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'page': instance.page,
      'limit': instance.limit,
    };

_SendReplyParams _$SendReplyParamsFromJson(Map<String, dynamic> json) =>
    _SendReplyParams(
      conversationId: (json['conversationId'] as num).toInt(),
      body: json['body'] as String?,
      templateId: (json['template_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SendReplyParamsToJson(_SendReplyParams instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'body': instance.body,
      'template_id': instance.templateId,
    };
