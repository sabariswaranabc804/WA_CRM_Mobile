import '../core/api_client.dart';
import '../models/conversation.dart';

/// Conversations and message threads — the Chats tab.
class InboxService {
  final ApiClient api;

  InboxService(this.api);

  Future<Paged<Conversation>> listConversations({
    String status = 'all',
    String? search,
    int page = 1,
    int limit = 30,
  }) async {
    final envelope = await api.getEnvelope('/conversations', query: {
      'status': status,
      'channel': 'whatsapp',
      'search': search,
      'page': page,
      'limit': limit,
    });
    return Paged.fromEnvelope(envelope, Conversation.fromJson);
  }

  Future<Conversation> getConversation(int id) async {
    final data = await api.get('/conversations/$id');
    return Conversation.fromJson(Map<String, dynamic>.from(data as Map));
  }

  /// Newest-first from the API; the thread view reverses for display.
  Future<Paged<Message>> listMessages(
    int conversationId, {
    int page = 1,
    int limit = 50,
  }) async {
    final envelope = await api.getEnvelope(
      '/conversations/$conversationId/messages',
      query: {'page': page, 'limit': limit},
    );
    return Paged.fromEnvelope(envelope, Message.fromJson);
  }

  Future<int> unreadCount() async {
    final data = await api.get('/conversations/unread-count');
    if (data is Map && data['count'] != null) {
      return int.tryParse('${data['count']}') ?? 0;
    }
    return 0;
  }

  /// Sends free text, or an approved template when the 24h window has closed.
  Future<void> reply(
    int conversationId, {
    String? body,
    int? templateId,
  }) async {
    await api.post('/conversations/$conversationId/reply', body: {
      if (body != null && body.isNotEmpty) 'body': body,
      'template_id': ?templateId,
    });
  }

  Future<void> markRead(int conversationId) =>
      api.post('/conversations/$conversationId/read');

  Future<void> close(int conversationId) =>
      api.post('/conversations/$conversationId/close');

  /// Finds an existing conversation for a contact.
  ///
  /// The tenant API has no `POST /conversations` — threads are created by
  /// inbound webhooks, automations or campaigns — so "new chat" can only open
  /// a conversation that already exists. Returns null when there is none.
  Future<Conversation?> findByContact(int contactId, {String? searchHint}) async {
    final page = await listConversations(search: searchHint, limit: 100);
    for (final conversation in page.items) {
      if (conversation.contactId == contactId) return conversation;
    }
    return null;
  }
}
