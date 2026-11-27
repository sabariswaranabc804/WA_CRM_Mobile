import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wa_crm_mobile/core/utils/json_utils.dart';
import 'chat_pagination.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
abstract class ChatMessage with _$ChatMessage {
  const ChatMessage._();

  const factory ChatMessage({
    @JsonKey(fromJson: asInt) required int id,
    @JsonKey(name: 'conversation_id', fromJson: asInt) required int conversationId,
    @Default('inbound') String direction,
    @JsonKey(name: 'sender_type') String? senderType,
    @JsonKey(name: 'content_type') String? contentType,
    String? body,
    @JsonKey(name: 'template_id', fromJson: asIntOrNull) int? templateId,
    @Default('sent') String status,
    @JsonKey(name: 'error_message') String? errorMessage,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  bool get isOutbound => direction == 'outbound';
  bool get hasFailed => status == 'failed';
  bool get isDelivered => status == 'delivered' || status == 'read';
  bool get isRead => status == 'read';

  String get displayBody {
    if (body != null && body!.isNotEmpty) return body!;
    switch (contentType) {
      case 'image':
        return '📷 Photo';
      case 'video':
        return '🎥 Video';
      case 'audio':
        return '🎤 Voice message';
      case 'document':
        return '📄 Document';
      case 'location':
        return '📍 Location';
      case 'contacts':
        return '👤 Contact card';
      case 'template':
        return '📋 Template message';
      default:
        return '(no content)';
    }
  }
}

@freezed
abstract class MessagesPagedResponse with _$MessagesPagedResponse {
  const factory MessagesPagedResponse({
    @Default([]) List<ChatMessage> data,
    ChatPagination? pagination,
  }) = _MessagesPagedResponse;

  factory MessagesPagedResponse.fromJson(Map<String, dynamic> json) =>
      _$MessagesPagedResponseFromJson(json);
}
