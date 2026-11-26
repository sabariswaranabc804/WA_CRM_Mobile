import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/json_utils.dart';
import 'package:mobileapp/models/contact.dart';
import 'package:mobileapp/models/conversation.dart';
import 'package:mobileapp/models/template.dart';

void main() {
  group('json coercion', () {
    test('reads MSSQL BIT columns returned as 0/1', () {
      expect(asBool(1), isTrue);
      expect(asBool(0), isFalse);
      expect(asBool('1'), isTrue);
      expect(asBool(null, true), isTrue, reason: 'falls back when absent');
    });

    test('reads numbers arriving as strings', () {
      expect(asInt('42'), 42);
      expect(asInt(null, 7), 7);
      expect(asIntOrNull(null), isNull);
    });

    test('treats blank strings as absent', () {
      expect(asStringOrNull('   '), isNull);
      expect(asStringOrNull('hi'), 'hi');
    });
  });

  group('Conversation', () {
    Map<String, dynamic> base(Map<String, dynamic> overrides) => {
          'id': 1,
          'contact_id': 9,
          'channel': 'whatsapp',
          'status': 'open',
          'unread_count': 0,
          'within_session_window': 1,
          ...overrides,
        };

    test('falls back through identifiers for its title', () {
      expect(
        Conversation.fromJson(base({'contact_name': 'Ravi'})).title,
        'Ravi',
      );
      expect(
        Conversation.fromJson(base({'contact_phone': '+91987'})).title,
        '+91987',
      );
      expect(Conversation.fromJson(base({})).title, 'Unknown contact');
    });

    test('prefixes outbound previews with "You:"', () {
      final conversation = Conversation.fromJson(base({
        'last_message_body': 'Order shipped',
        'last_message_direction': 'outbound',
      }));
      expect(conversation.preview, 'You: Order shipped');
    });

    test('labels media previews instead of showing an empty body', () {
      final conversation = Conversation.fromJson(base({
        'last_message_content_type': 'image',
        'last_message_direction': 'inbound',
      }));
      expect(conversation.preview, '📷 Photo');
    });

    test('says so when there are no messages', () {
      expect(Conversation.fromJson(base({})).preview, 'No messages yet');
    });

    test('collapses whitespace in a preview', () {
      final conversation = Conversation.fromJson(base({
        'last_message_body': 'line one\n\nline two',
        'last_message_direction': 'inbound',
      }));
      expect(conversation.preview, 'line one line two');
    });
  });

  group('Paged', () {
    test('reads the pagination envelope', () {
      final paged = Paged.fromEnvelope({
        'data': [
          {'id': 1, 'contact_id': 2},
        ],
        'pagination': {'page': 2, 'limit': 30, 'total': 45, 'totalPages': 2},
      }, Conversation.fromJson);

      expect(paged.items, hasLength(1));
      expect(paged.page, 2);
      expect(paged.hasMore, isFalse);
    });

    test('reports more pages when the cursor is short of the end', () {
      final paged = Paged.fromEnvelope({
        'data': <Map<String, dynamic>>[],
        'pagination': {'page': 1, 'totalPages': 3, 'total': 90},
      }, Conversation.fromJson);

      expect(paged.hasMore, isTrue);
    });
  });

  group('MessageTemplate placeholders', () {
    /// The real pet_test_coupon body, trimmed to the lines that matter.
    final coupon = MessageTemplate.fromJson({
      'id': 9,
      'name': 'pet_test_coupon',
      'status': 'approved',
      'body': 'Coupon Code:{{1}}\nOffer: {{2}}\nValid Until: {{3}}',
      'variables': [
        {'name': 'Coupon Code', 'type': 'text', 'sample': 'SCRATCH50'},
        {'name': 'Offer', 'type': 'text', 'sample': '50% off'},
        {'name': 'Valid Until', 'type': 'text', 'sample': '31 Aug 2026'},
      ],
    });

    test('finds each placeholder in order', () {
      expect(coupon.placeholderIndices, [1, 2, 3]);
      expect(coupon.placeholderCount, 3);
    });

    test('counts a repeated index once', () {
      final repeated = MessageTemplate.fromJson({
        'id': 1,
        'name': 'hi',
        'body': 'Hi {{1}}, thanks {{1}} — see you {{2}}.',
      });
      // Meta takes one value per index, however often the body uses it.
      expect(repeated.placeholderIndices, [1, 2]);
    });

    test('tolerates whitespace inside the braces', () {
      final spaced = MessageTemplate.fromJson({
        'id': 2,
        'name': 'sp',
        'body': 'Hello {{ 1 }}',
      });
      expect(spaced.placeholderCount, 1);
    });

    test('reads placeholders from the body even when none are declared', () {
      final undeclared = MessageTemplate.fromJson({
        'id': 3,
        'name': 'imported',
        'body': 'Order {{1}} ships {{2}}',
        'variables': <Map<String, dynamic>>[],
      });
      // Imported templates can carry placeholders they never declared.
      expect(undeclared.placeholderCount, 2);
    });

    test('labels fields from the declared names', () {
      expect(coupon.labelFor(0), 'Coupon Code');
      expect(coupon.labelFor(2), 'Valid Until');
    });

    test('falls back to the placeholder number when unnamed', () {
      final bare = MessageTemplate.fromJson({
        'id': 4,
        'name': 'bare',
        'body': 'Hi {{1}} and {{2}}',
      });
      expect(bare.labelFor(0), 'Value {{1}}');
      expect(bare.labelFor(1), 'Value {{2}}');
    });

    test('offers Meta review samples to prefill', () {
      expect(coupon.sampleFor(0), 'SCRATCH50');
      expect(coupon.sampleFor(9), isNull);
    });

    test('substitutes values into the preview', () {
      final rendered = coupon.preview(['SCRATCH50', '50% off', '31 Aug']);
      expect(rendered, contains('Coupon Code:SCRATCH50'));
      expect(rendered, contains('Offer: 50% off'));
      expect(rendered, contains('Valid Until: 31 Aug'));
      expect(rendered, isNot(contains('{{')));
    });

    test('leaves unfilled placeholders visible in the preview', () {
      final rendered = coupon.preview(['SCRATCH50', '', '']);
      expect(rendered, contains('Coupon Code:SCRATCH50'));
      // Blank values must not silently render as empty text.
      expect(rendered, contains('{{2}}'));
      expect(rendered, contains('{{3}}'));
    });

    test('a template without placeholders needs no values', () {
      final plain = MessageTemplate.fromJson({
        'id': 5,
        'name': 'thanks',
        'body': 'Thanks for shopping with us.',
      });
      expect(plain.placeholderCount, 0);
      expect(plain.hasVariables, isFalse);
      expect(plain.preview(const []), 'Thanks for shopping with us.');
    });
  });

  group('MessageTemplate', () {
    test('flags placeholders declared as variables', () {
      final template = MessageTemplate.fromJson({
        'id': 1,
        'name': 'welcome',
        'body': 'Hello there',
        'variables': [
          {'name': '1', 'type': 'text'},
        ],
        'status': 'approved',
      });
      expect(template.hasVariables, isTrue);
    });

    test('flags placeholders found only in the body', () {
      final template = MessageTemplate.fromJson({
        'id': 2,
        'name': 'order',
        'body': 'Hi {{1}}, your order shipped.',
        'status': 'approved',
      });
      expect(template.hasVariables, isTrue);
    });

    test('leaves a plain template sendable', () {
      final template = MessageTemplate.fromJson({
        'id': 3,
        'name': 'thanks',
        'body': 'Thanks for shopping with us.',
        'status': 'approved',
      });
      expect(template.hasVariables, isFalse);
      expect(template.canSend, isTrue);
    });
  });

  group('ContactPage', () {
    test('knows when more contacts remain', () {
      final page = ContactPage.fromJson({
        'contacts': [
          {'id': 1, 'full_name': 'A'},
          {'id': 2, 'full_name': 'B'},
        ],
        'total': 10,
        'limit': 2,
        'offset': 0,
      });
      expect(page.hasMore, isTrue);
      expect(page.contacts.first.subtitle, 'No contact details');
    });

    test('stops paging at the last page', () {
      final page = ContactPage.fromJson({
        'contacts': [
          {'id': 3, 'full_name': 'C', 'phone': '+123'},
        ],
        'total': 3,
        'limit': 2,
        'offset': 2,
      });
      expect(page.hasMore, isFalse);
      expect(page.contacts.first.subtitle, '+123');
    });
  });
}
