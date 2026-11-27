import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wa_crm_mobile/core/utils/json_utils.dart';
import 'chat_pagination.dart';

part 'chat_conversation.freezed.dart';
part 'chat_conversation.g.dart';

@freezed
abstract class ChatConversation with _$ChatConversation {
  const ChatConversation._();

  const factory ChatConversation({
    @JsonKey(fromJson: asInt) required int id,
    @JsonKey(name: 'contact_id', fromJson: asInt) required int contactId,
    @Default('whatsapp') String channel,
    @Default('open') String status,
    @JsonKey(name: 'assigned_to', fromJson: asIntOrNull) int? assignedTo,
    @JsonKey(name: 'assigned_to_name') String? assignedToName,
    @JsonKey(name: 'last_message_at') String? lastMessageAt,
    @JsonKey(name: 'unread_count', fromJson: asInt) @Default(0) int unreadCount,
    @JsonKey(name: 'within_session_window', fromJson: asBool)
    @Default(true)
    bool withinSessionWindow,
    @JsonKey(name: 'contact_name') String? contactName,
    @JsonKey(name: 'contact_phone') String? contactPhone,
    @JsonKey(name: 'contact_email') String? contactEmail,
    @JsonKey(name: 'contact_instagram_handle') String? contactInstagramHandle,
    @JsonKey(name: 'last_message_body') String? lastMessageBody,
    @JsonKey(name: 'last_message_content_type') String? lastMessageContentType,
    @JsonKey(name: 'last_message_direction') String? lastMessageDirection,
  }) = _ChatConversation;

  factory ChatConversation.fromJson(Map<String, dynamic> json) =>
      _$ChatConversationFromJson(json);

  String get title =>
      contactName ??
      contactPhone ??
      contactEmail ??
      contactInstagramHandle ??
      'Unknown contact';

  bool get isClosed => status == 'closed';

  String get preview {
    const placeholders = {
      'image': '📷 Photo',
      'video': '🎥 Video',
      'audio': '🎤 Voice message',
      'document': '📄 Document',
      'location': '📍 Location',
      'contacts': '👤 Contact card',
      'reaction': '💬 Reaction',
      'template': '📋 Template message',
    };

    final placeholder = placeholders[lastMessageContentType];
    final text = placeholder ??
        lastMessageBody?.replaceAll(RegExp(r'\s+'), ' ').trim();

    if (text == null || text.isEmpty) return 'No messages yet';
    return lastMessageDirection == 'outbound' ? 'You: $text' : text;
  }
}

@freezed
abstract class ConversationsPagedResponse with _$ConversationsPagedResponse {
  const factory ConversationsPagedResponse({
    @Default([]) List<ChatConversation> data,
    ChatPagination? pagination,
  }) = _ConversationsPagedResponse;

  factory ConversationsPagedResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationsPagedResponseFromJson(json);
}
