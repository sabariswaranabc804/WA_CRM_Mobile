import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/formatters.dart';

void main() {
  group('slugify', () {
    test('matches the slug rule in login.use-case.js', () {
      expect(slugify('Test Corp 1'), 'test-corp-1');
      expect(slugify('  Acme  '), 'acme');
      expect(slugify('already-a-slug'), 'already-a-slug');
      expect(slugify('Foo & Bar!'), 'foo-bar');
    });
  });

  group('initialsFor', () {
    test('takes up to two initials', () {
      expect(initialsFor('Ravi Kumar'), 'RK');
      expect(initialsFor('Priya'), 'P');
      expect(initialsFor('a b c d'), 'AB');
    });

    test('degrades to a placeholder when there is no name', () {
      expect(initialsFor('   '), '?');
    });
  });

  group('chatListTimestamp', () {
    test('shows Yesterday for the previous day', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(chatListTimestamp(yesterday), 'Yesterday');
    });

    test('falls back to a date beyond a week', () {
      final old = DateTime.now().subtract(const Duration(days: 30));
      expect(chatListTimestamp(old), contains('/'));
    });

    test('renders nothing for a missing timestamp', () {
      expect(chatListTimestamp(null), '');
    });
  });

  group('dayDivider', () {
    test('labels today and yesterday', () {
      expect(dayDivider(DateTime.now()), 'TODAY');
      expect(
        dayDivider(DateTime.now().subtract(const Duration(days: 1))),
        'YESTERDAY',
      );
    });
  });
}
