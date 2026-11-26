import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/token_storage.dart';
import 'package:mobileapp/screens/settings/settings_screen.dart';
import 'package:mobileapp/state/app_services.dart';
import 'package:mobileapp/state/auth_state.dart';
import 'package:mobileapp/state/theme_state.dart';
import 'package:mobileapp/ui/ui.dart';
import 'package:provider/provider.dart';

void main() {
  late InMemoryKeyValueStore store;
  late TokenStorage storage;

  setUp(() {
    store = InMemoryKeyValueStore();
    storage = TokenStorage(store);
  });

  group('ThemeState', () {
    test('follows the device until the user chooses', () async {
      final theme = ThemeState(storage);
      await theme.bootstrap();

      expect(theme.mode, ThemeMode.system);
    });

    test('persists a chosen mode', () async {
      final theme = ThemeState(storage);
      await theme.setMode(ThemeMode.dark);

      expect(store.values['theme'], 'dark');
    });

    test('restores the stored mode on next launch', () async {
      await storage.saveTheme('light');

      final theme = ThemeState(storage);
      await theme.bootstrap();

      expect(theme.mode, ThemeMode.light);
    });

    test('falls back to system for an unrecognised value', () async {
      await storage.saveTheme('solarized');

      final theme = ThemeState(storage);
      await theme.bootstrap();

      expect(theme.mode, ThemeMode.system);
    });

    test('notifies listeners when the mode changes', () async {
      final theme = ThemeState(storage);
      var notifications = 0;
      theme.addListener(() => notifications++);

      await theme.setMode(ThemeMode.dark);
      expect(notifications, 1);

      // Re-selecting the same mode is a no-op, so the UI does not rebuild.
      await theme.setMode(ThemeMode.dark);
      expect(notifications, 1);
    });

    test('does not notify when bootstrap finds the default', () async {
      final theme = ThemeState(storage);
      var notifications = 0;
      theme.addListener(() => notifications++);

      await theme.bootstrap();
      expect(notifications, 0);
    });
  });

  group('labels', () {
    test('name each mode', () {
      expect(themeModeLabel(ThemeMode.system), 'System');
      expect(themeModeLabel(ThemeMode.light), 'Light');
      expect(themeModeLabel(ThemeMode.dark), 'Dark');
    });
  });

  group('the Settings selector', () {
    /// Pumps the real Settings screen with in-memory storage, so the selector
    /// is exercised exactly as it ships.
    Future<ThemeState> pumpSettings(WidgetTester tester) async {
      final services = AppServices.create();
      final theme = ThemeState(storage);

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider<AppServices>.value(value: services),
            ChangeNotifierProvider<AuthState>(create: (_) => AuthState(services)),
            ChangeNotifierProvider<ThemeState>.value(value: theme),
          ],
          child: MaterialApp(
            theme: buildLightTheme(),
            darkTheme: buildDarkTheme(),
            themeMode: theme.mode,
            home: const SettingsScreen(),
          ),
        ),
      );
      await tester.pump();
      return theme;
    }

    testWidgets('offers all three modes', (tester) async {
      await pumpSettings(tester);

      // AppSectionHeader renders its label uppercased.
      expect(find.text('APPEARANCE'), findsOneWidget);
      expect(find.text('System'), findsOneWidget);
      expect(find.text('Light'), findsOneWidget);
      expect(find.text('Dark'), findsOneWidget);
    });

    testWidgets('switching to Dark updates and persists the mode',
        (tester) async {
      final theme = await pumpSettings(tester);
      expect(theme.mode, ThemeMode.system);

      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();

      expect(theme.mode, ThemeMode.dark);
      expect(store.values['theme'], 'dark');
    });

    testWidgets('explains what the current choice means', (tester) async {
      final theme = await pumpSettings(tester);

      expect(
        find.textContaining('Following your device setting'),
        findsOneWidget,
      );

      await theme.setMode(ThemeMode.light);
      await tester.pumpAndSettle();

      expect(find.textContaining('regardless of your device'), findsOneWidget);
    });
  });
}
