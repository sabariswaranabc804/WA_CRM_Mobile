import 'package:flutter_test/flutter_test.dart';
import 'package:wa_crm_mobile/features/chat/domain/models/chat_conversation.dart';

void main() {
  group('ChatConversation JSON parsing', () {
    test('correctly parses user API payload with string IDs and string/bool fields', () {
      final jsonPayload = {
        'id': '27',
        'tenant_id': '5',
        'channel_account_id': '4',
        'contact_id': '126',
        'channel': 'whatsapp',
        'status': 'open',
        'assigned_to': null,
        'last_message_at': '2026-11-27T09:52:38.003Z',
        'last_customer_message_at': '2026-11-24T06:24:01.000Z',
        'unread_count': 0,
        'within_session_window': false,
        'contact_name': 'nithya',
        'contact_phone': '919942355499',
        'contact_email': 'nithya@gmail.com',
        'last_message_body': 'Hello nithya 👋',
        'last_message_content_type': 'template',
        'last_message_direction': 'outbound',
      };

      final conversation = ChatConversation.fromJson(jsonPayload);

      expect(conversation.id, equals(27));
      expect(conversation.contactId, equals(126));
      expect(conversation.assignedTo, isNull);
      expect(conversation.channel, equals('whatsapp'));
      expect(conversation.status, equals('open'));
      expect(conversation.withinSessionWindow, isFalse);
      expect(conversation.title, equals('nithya'));
      expect(conversation.preview, contains('Template message'));
    });

    test('handles numeric IDs and integer within_session_window gracefully', () {
      final jsonPayload = {
        'id': 105,
        'contact_id': 200,
        'assigned_to': '42',
        'unread_count': '5',
        'within_session_window': 1,
        'contact_phone': '919876543210',
      };

      final conversation = ChatConversation.fromJson(jsonPayload);

      expect(conversation.id, equals(105));
      expect(conversation.contactId, equals(200));
      expect(conversation.assignedTo, equals(42));
      expect(conversation.unreadCount, equals(5));
      expect(conversation.withinSessionWindow, isTrue);
      expect(conversation.title, equals('919876543210'));
    });
  });
}
