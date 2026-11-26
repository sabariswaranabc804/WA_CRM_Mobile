import 'package:flutter/material.dart';

import '../core/token_storage.dart';

/// Owns the light/dark preference and persists it.
///
/// The web client offers only light and dark; mobile adds **System**, which
/// follows the device setting, and uses it as the default — that is what a
/// phone user expects, and it is what the app did before the choice existed.
class ThemeState extends ChangeNotifier {
  final TokenStorage storage;

  ThemeMode _mode = ThemeMode.system;

  ThemeState(this.storage);

  ThemeMode get mode => _mode;

  /// Reads the stored preference. Safe to call before the first frame.
  Future<void> bootstrap() async {
    final stored = await storage.readTheme();
    final restored = _decode(stored);
    if (restored == _mode) return;
    _mode = restored;
    notifyListeners();
  }

  Future<void> setMode(ThemeMode next) async {
    if (next == _mode) return;
    _mode = next;
    notifyListeners();
    await storage.saveTheme(_encode(next));
  }

  /// What the user sees right now, resolving [ThemeMode.system] against the
  /// device setting — used to label the current choice.
  bool isDark(BuildContext context) => switch (_mode) {
        ThemeMode.dark => true,
        ThemeMode.light => false,
        ThemeMode.system =>
          MediaQuery.platformBrightnessOf(context) == Brightness.dark,
      };

  static String _encode(ThemeMode mode) => switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      };

  /// Unrecognised or missing values fall back to following the device.
  static ThemeMode _decode(String? stored) => switch (stored) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
}

/// Display label for each option.
String themeModeLabel(ThemeMode mode) => switch (mode) {
      ThemeMode.system => 'System',
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
    };

IconData themeModeIcon(ThemeMode mode) => switch (mode) {
      ThemeMode.system => Icons.brightness_auto_outlined,
      ThemeMode.light => Icons.light_mode_outlined,
      ThemeMode.dark => Icons.dark_mode_outlined,
    };
