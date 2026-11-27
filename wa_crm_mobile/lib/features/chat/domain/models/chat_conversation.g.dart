// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatConversation _$ChatConversationFromJson(Map<String, dynamic> json) =>
    _ChatConversation(
      id: asInt(json['id']),
      contactId: asInt(json['contact_id']),
      channel: json['channel'] as String? ?? 'whatsapp',
      status: json['status'] as String? ?? 'open',
      assignedTo: asIntOrNull(json['assigned_to']),
      assignedToName: json['assigned_to_name'] as String?,
      lastMessageAt: json['last_message_at'] as String?,
      unreadCount: json['unread_count'] == null
          ? 0
          : asInt(json['unread_count']),
      withinSessionWindow: json['within_session_window'] == null
          ? true
          : asBool(json['within_session_window']),
      contactName: json['contact_name'] as String?,
      contactPhone: json['contact_phone'] as String?,
      contactEmail: json['contact_email'] as String?,
      contactInstagramHandle: json['contact_instagram_handle'] as String?,
      lastMessageBody: json['last_message_body'] as String?,
      lastMessageContentType: json['last_message_content_type'] as String?,
      lastMessageDirection: json['last_message_direction'] as String?,
    );

Map<String, dynamic> _$ChatConversationToJson(_ChatConversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contact_id': instance.contactId,
      'channel': instance.channel,
      'status': instance.status,
      'assigned_to': instance.assignedTo,
      'assigned_to_name': instance.assignedToName,
      'last_message_at': instance.lastMessageAt,
      'unread_count': instance.unreadCount,
      'within_session_window': instance.withinSessionWindow,
      'contact_name': instance.contactName,
      'contact_phone': instance.contactPhone,
      'contact_email': instance.contactEmail,
      'contact_instagram_handle': instance.contactInstagramHandle,
      'last_message_body': instance.lastMessageBody,
      'last_message_content_type': instance.lastMessageContentType,
      'last_message_direction': instance.lastMessageDirection,
    };

_ConversationsPagedResponse _$ConversationsPagedResponseFromJson(
  Map<String, dynamic> json,
) => _ConversationsPagedResponse(
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => ChatConversation.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pagination: json['pagination'] == null
      ? null
      : ChatPagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ConversationsPagedResponseToJson(
  _ConversationsPagedResponse instance,
) => <String, dynamic>{
  'data': instance.data,
  'pagination': instance.pagination,
};
