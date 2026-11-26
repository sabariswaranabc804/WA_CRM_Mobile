import '../core/json_utils.dart';

/// Mirrors the payload of `GET /api/v1/conversations`. Field names stay
/// snake_case at the JSON boundary to match the API exactly.
class Conversation {
  final int id;
  final int contactId;
  final String channel;
  final String status;
  final int? assignedTo;
  final String? assignedToName;
  final DateTime? lastMessageAt;
  final int unreadCount;

  /// False once 24h have passed since the last inbound message — a free-text
  /// reply will be rejected by Meta and a template is required instead.
  final bool withinSessionWindow;

  final String? contactName;
  final String? contactPhone;
  final String? contactEmail;
  final String? contactInstagramHandle;

  final String? lastMessageBody;
  final String? lastMessageContentType;
  final String? lastMessageDirection;

  const Conversation({
    required this.id,
    required this.contactId,
    required this.channel,
    required this.status,
    required this.assignedTo,
    required this.assignedToName,
    required this.lastMessageAt,
    required this.unreadCount,
    required this.withinSessionWindow,
    required this.contactName,
    required this.contactPhone,
    required this.contactEmail,
    required this.contactInstagramHandle,
    required this.lastMessageBody,
    required this.lastMessageContentType,
    required this.lastMessageDirection,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: asInt(json['id']),
      contactId: asInt(json['contact_id']),
      channel: asString(json['channel'], 'whatsapp'),
      status: asString(json['status'], 'open'),
      assignedTo: asIntOrNull(json['assigned_to']),
      assignedToName: asStringOrNull(json['assigned_to_name']),
      lastMessageAt: asDate(json['last_message_at']),
      unreadCount: asInt(json['unread_count']),
      withinSessionWindow: asBool(json['within_session_window'], true),
      contactName: asStringOrNull(json['contact_name']),
      contactPhone: asStringOrNull(json['contact_phone']),
      contactEmail: asStringOrNull(json['contact_email']),
      contactInstagramHandle: asStringOrNull(json['contact_instagram_handle']),
      lastMessageBody: asStringOrNull(json['last_message_body']),
      lastMessageContentType: asStringOrNull(json['last_message_content_type']),
      lastMessageDirection: asStringOrNull(json['last_message_direction']),
    );
  }

  /// Display name, falling back through whichever identifier exists.
  String get title =>
      contactName ??
      contactPhone ??
      contactEmail ??
      contactInstagramHandle ??
      'Unknown contact';

  bool get isClosed => status == 'closed';

  /// Preview line under the name. Non-text messages have no useful body, so
  /// they get a labelled placeholder.
  String get preview {
    const placeholders = {
      'image': '📷 Photo',
      'video': '🎥 Video',
      'audio': '🎤 Voice message',
      'document': '📄 Document',
      'location': '📍 Location',
      'contacts': '👤 Contact card',
      'reaction': '💬 Reaction',
    };

    final placeholder = placeholders[lastMessageContentType];
    final text = placeholder ??
        lastMessageBody?.replaceAll(RegExp(r'\s+'), ' ').trim();

    if (text == null || text.isEmpty) return 'No messages yet';
    return lastMessageDirection == 'outbound' ? 'You: $text' : text;
  }
}

/// A single message in a thread.
class Message {
  final int id;
  final int conversationId;
  final String direction;
  final String? senderType;
  final String? contentType;
  final String? body;
  final int? templateId;
  final String status;
  final String? errorMessage;
  final DateTime? createdAt;

  const Message({
    required this.id,
    required this.conversationId,
    required this.direction,
    required this.senderType,
    required this.contentType,
    required this.body,
    required this.templateId,
    required this.status,
    required this.errorMessage,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: asInt(json['id']),
      conversationId: asInt(json['conversation_id']),
      direction: asString(json['direction'], 'inbound'),
      senderType: asStringOrNull(json['sender_type']),
      contentType: asStringOrNull(json['content_type']),
      body: asStringOrNull(json['body']),
      templateId: asIntOrNull(json['template_id']),
      status: asString(json['status'], 'sent'),
      errorMessage: asStringOrNull(json['error_message']),
      createdAt: asDate(json['created_at']),
    );
  }

  bool get isOutbound => direction == 'outbound';
  bool get hasFailed => status == 'failed';

  /// What to render when the message carries media rather than text.
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

/// The `{ data, pagination }` envelope the list endpoints return.
class Paged<T> {
  final List<T> items;
  final int page;
  final int totalPages;
  final int total;

  const Paged({
    required this.items,
    required this.page,
    required this.totalPages,
    required this.total,
  });

  bool get hasMore => page < totalPages;

  factory Paged.fromEnvelope(
    Map<String, dynamic> envelope,
    T Function(Map<String, dynamic>) parse,
  ) {
    final pagination = envelope['pagination'];
    final page = pagination is Map ? asInt(pagination['page'], 1) : 1;
    final totalPages = pagination is Map ? asInt(pagination['totalPages'], 1) : 1;
    final total = pagination is Map ? asInt(pagination['total']) : 0;

    return Paged(
      items: asMapList(envelope['data']).map(parse).toList(),
      page: page,
      totalPages: totalPages,
      total: total,
    );
  }
}
