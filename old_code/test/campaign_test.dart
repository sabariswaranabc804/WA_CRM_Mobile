import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/formatters.dart';
import 'package:mobileapp/models/campaign.dart';
import 'package:mobileapp/models/channel_account.dart';
import 'package:mobileapp/models/contact_list.dart';
import 'package:mobileapp/screens/campaigns/campaigns_screen.dart';
import 'package:mobileapp/ui/ui.dart';

void main() {
  group('toApiTimestamp', () {
    /// `z.string().datetime({ precision: 3 })` accepts exactly three fractional
    /// digits and a Z suffix — nothing else.
    final validatorShape =
        RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z$');

    test('emits exactly millisecond precision', () {
      final stamp = toApiTimestamp(DateTime.utc(2026, 8, 16, 10, 30));
      expect(stamp, '2026-08-16T10:30:00.000Z');
      expect(validatorShape.hasMatch(stamp), isTrue);
    });

    test('truncates microseconds rather than emitting six digits', () {
      final withMicros =
          DateTime.utc(2026, 8, 16, 10, 30, 15, 250, 456);
      final stamp = toApiTimestamp(withMicros);

      expect(stamp, '2026-08-16T10:30:15.250Z');
      expect(validatorShape.hasMatch(stamp), isTrue,
          reason: 'microseconds would make the validator reject it');
    });

    test('converts local times to UTC', () {
      final local = DateTime(2026, 8, 16, 10, 30);
      final stamp = toApiTimestamp(local);

      expect(stamp.endsWith('Z'), isTrue);
      expect(validatorShape.hasMatch(stamp), isTrue);
      expect(
        DateTime.parse(stamp).isAtSameMomentAs(local),
        isTrue,
        reason: 'the instant must survive the conversion',
      );
    });
  });

  group('Campaign', () {
    Campaign build(Map<String, dynamic> overrides) => Campaign.fromJson({
          'id': 1,
          'name': 'Diwali offer',
          'status': 'sending',
          ...overrides,
        });

    test('reports send progress as a fraction', () {
      final campaign = build({'total_recipients': 200, 'sent_count': 50});
      expect(campaign.progress, 0.25);
    });

    test('has no progress before recipients are resolved', () {
      expect(build({'total_recipients': 0}).progress, isNull);
    });

    test('clamps progress when the server over-counts', () {
      final campaign = build({'total_recipients': 10, 'sent_count': 25});
      expect(campaign.progress, 1.0);
    });
  });

  group('ChannelAccount', () {
    test('prefers the masked phone number as its subtitle', () {
      final account = ChannelAccount.fromJson({
        'id': 3,
        'label': 'Main line',
        'status': 'connected',
        'display_phone_number': '+9****4210',
        'verified_name': 'Acme Corp',
      });

      expect(account.subtitle, '+9****4210');
      expect(account.isConnected, isTrue);
    });

    test('falls back through the identifiers it has', () {
      final account = ChannelAccount.fromJson({
        'id': 4,
        'label': 'Spare',
        'status': 'disconnected',
        'verified_name': 'Acme Corp',
      });

      expect(account.subtitle, 'Acme Corp');
      expect(account.isConnected, isFalse);
    });
  });

  group('ContactList', () {
    test('distinguishes dynamic from static lists', () {
      expect(
        ContactList.fromJson({'id': 1, 'name': 'VIP', 'type': 'dynamic'})
            .isDynamic,
        isTrue,
      );
      expect(
        ContactList.fromJson({'id': 2, 'name': 'All', 'type': 'static'})
            .isDynamic,
        isFalse,
      );
    });
  });

  group('CampaignCard on a phone', () {
    /// 375pt is the narrowest common phone width; a card that fits here fits
    /// everywhere. Any RenderFlex overflow fails the test.
    Future<void> pumpAt375(WidgetTester tester, Campaign campaign) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          theme: buildLightTheme(),
          home: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: CampaignCard(campaign: campaign, onTap: () {}),
            ),
          ),
        ),
      );
      await tester.pump();
    }

    testWidgets('lays out a sending campaign without overflowing',
        (tester) async {
      await pumpAt375(
        tester,
        Campaign.fromJson({
          'id': 1,
          'name': 'Diwali offer — VIP customers in Mumbai and Pune',
          'status': 'sending',
          'total_recipients': 1250,
          'sent_count': 500,
          'delivered_count': 480,
          'failed_count': 12,
          'started_at': '2026-08-16T09:00:00.000Z',
        }),
      );

      expect(tester.takeException(), isNull);
      expect(find.text('40%'), findsOneWidget);
      expect(find.text('SENDING'), findsOneWidget);
      expect(find.text('1250'), findsOneWidget);
    });

    testWidgets('a draft shows no progress bar', (tester) async {
      await pumpAt375(
        tester,
        Campaign.fromJson({
          'id': 2,
          'name': 'Untitled draft',
          'status': 'draft',
          'total_recipients': 0,
        }),
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(LinearProgressIndicator), findsNothing);
      expect(find.text('DRAFT'), findsOneWidget);
    });

    testWidgets('shows the most relevant date for the state', (tester) async {
      await pumpAt375(
        tester,
        Campaign.fromJson({
          'id': 3,
          'name': 'Done',
          'status': 'completed',
          'total_recipients': 10,
          'sent_count': 10,
          'scheduled_at': '2026-08-10T09:00:00.000Z',
          'completed_at': '2026-08-12T09:00:00.000Z',
        }),
      );

      expect(tester.takeException(), isNull);
      // Completion wins over the earlier scheduled time.
      expect(find.textContaining('Completed'), findsOneWidget);
      expect(find.textContaining('Scheduled'), findsNothing);
    });
  });
}
