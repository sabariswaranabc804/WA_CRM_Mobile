import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/ui/ui.dart';

/// Wraps a widget in just enough app to pump it.
Widget host(Widget child) => MaterialApp(
      theme: buildLightTheme(),
      home: Scaffold(body: child),
    );

void main() {
  group('AppButton', () {
    testWidgets('shows its label and fires onPressed', (tester) async {
      var taps = 0;
      await tester.pumpWidget(host(
        AppButton(label: 'Log in', onPressed: () => taps++),
      ));

      expect(find.text('Log in'), findsOneWidget);
      await tester.tap(find.text('Log in'));
      expect(taps, 1);
    });

    testWidgets('swaps the label for a spinner while loading', (tester) async {
      await tester.pumpWidget(host(
        AppButton(label: 'Log in', isLoading: true, onPressed: () {}),
      ));

      expect(find.text('Log in'), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('ignores taps while loading', (tester) async {
      var taps = 0;
      await tester.pumpWidget(host(
        AppButton(label: 'Save', isLoading: true, onPressed: () => taps++),
      ));

      await tester.tap(find.byType(AppButton));
      expect(taps, 0, reason: 'a loading button must not double-submit');
    });

    testWidgets('keeps the loading label when one is given', (tester) async {
      await tester.pumpWidget(host(
        AppButton(
          label: 'Send',
          loadingLabel: 'Sending…',
          isLoading: true,
          onPressed: () {},
        ),
      ));

      expect(find.text('Sending…'), findsOneWidget);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(host(const AppButton(label: 'Disabled')));

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
    });
  });

  group('AppInput', () {
    testWidgets('obscures a password and toggles visibility', (tester) async {
      await tester.pumpWidget(host(
        const AppInput(label: 'Password', isPassword: true),
      ));

      expect(tester.widget<TextField>(find.byType(TextField)).obscureText,
          isTrue);

      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pump();

      expect(tester.widget<TextField>(find.byType(TextField)).obscureText,
          isFalse);
    });

    testWidgets('surfaces validator errors', (tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(host(
        Form(
          key: formKey,
          child: const AppInput(
            label: 'Workspace',
            errorText: null,
          ),
        ),
      ));

      expect(find.text('Workspace'), findsOneWidget);
    });
  });

  group('AppBadge', () {
    test('maps statuses onto the shared semantic colours', () {
      expect(statusColor('approved'), AppColors.success);
      expect(statusColor('COMPLETED'), AppColors.success,
          reason: 'matching is case-insensitive');
      expect(statusColor('pending'), AppColors.warning);
      expect(statusColor('failed'), AppColors.danger);
      expect(statusColor('cancelled'), AppColors.neutral);
      expect(statusColor('draft'), AppColors.info);
    });

    testWidgets('renders the label uppercased', (tester) async {
      await tester.pumpWidget(host(AppBadge.status('approved')));
      expect(find.text('APPROVED'), findsOneWidget);
    });
  });

  group('AppFilterBar', () {
    testWidgets('capitalises options and reports the tapped one',
        (tester) async {
      String? picked;
      await tester.pumpWidget(host(
        AppFilterBar(
          options: const ['all', 'open', 'closed'],
          selected: 'all',
          onSelected: (v) => picked = v,
        ),
      ));

      expect(find.text('All'), findsOneWidget);
      expect(find.text('Open'), findsOneWidget);

      await tester.tap(find.text('Closed'));
      expect(picked, 'closed', reason: 'reports the raw API value, not the label');
    });
  });

  group('AppAsyncListView', () {
    Widget listWith({
      bool isLoading = false,
      String? error,
      List<String> items = const [],
    }) {
      return host(
        AppAsyncListView<String>(
          isLoading: isLoading,
          error: error,
          items: items,
          onRetry: () {},
          emptyState: const AppEmptyState(
            icon: Icons.inbox,
            title: 'Nothing here',
          ),
          itemBuilder: (_, item, _) => ListTile(title: Text(item)),
        ),
      );
    }

    testWidgets('shows a spinner while loading', (tester) async {
      await tester.pumpWidget(listWith(isLoading: true));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows the error and a retry action', (tester) async {
      await tester.pumpWidget(listWith(error: 'Server unreachable'));
      await tester.pump();

      expect(find.text('Server unreachable'), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
    });

    testWidgets('shows the empty state when there are no items',
        (tester) async {
      await tester.pumpWidget(listWith());
      expect(find.text('Nothing here'), findsOneWidget);
    });

    testWidgets('renders items once loaded', (tester) async {
      await tester.pumpWidget(listWith(items: ['Ravi', 'Priya']));

      expect(find.text('Ravi'), findsOneWidget);
      expect(find.text('Priya'), findsOneWidget);
      expect(find.text('Nothing here'), findsNothing);
    });

    testWidgets('error takes precedence over stale items', (tester) async {
      await tester.pumpWidget(listWith(error: 'Boom', items: ['Ravi']));
      await tester.pump();

      expect(find.text('Ravi'), findsNothing);
      expect(find.text('Boom'), findsOneWidget);
    });
  });

  group('AppAvatar', () {
    testWidgets('shows initials', (tester) async {
      await tester.pumpWidget(host(const AppAvatar(name: 'Ravi Kumar', id: 3)));
      expect(find.text('RK'), findsOneWidget);
    });

    test('gives the same contact the same colour every time', () {
      expect(avatarColorFor(42), avatarColorFor(42));
    });
  });
}
