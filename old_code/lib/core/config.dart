import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

/// Where the app looks for the Bulk Chat API.
///
/// The server listens on 3001 (see `server/.env`). The default differs per
/// platform because "localhost" means the device itself: on the Android
/// emulator the host machine is reachable at 10.0.2.2 instead.
///
/// Override at build time with:
///   flutter run --dart-define=API_BASE_URL=http://192.168.1.5:3001/api/v1
/// or at runtime from the login screen's server settings.
class AppConfig {
  static const String _compileTimeBaseUrl = String.fromEnvironment('API_BASE_URL');

  /// Set once at startup from stored preferences; null means "use the default".
  static String? _runtimeBaseUrl;

  static String get defaultBaseUrl => "https://confidentiality-female-upgrades-swap.trycloudflare.com/api/v1";
  
  // {
  //   if (_compileTimeBaseUrl.isNotEmpty) return _compileTimeBaseUrl;
  //   if (!kIsWeb && Platform.isAndroid) return 'http://10.0.2.2:3001/api/v1';
  //   return 'http://localhost:3001/api/v1';
  // }

  static String get apiBaseUrl => _runtimeBaseUrl ?? defaultBaseUrl;

  static void setRuntimeBaseUrl(String? url) {
    final trimmed = url?.trim();
    _runtimeBaseUrl = (trimmed == null || trimmed.isEmpty) ? null : trimmed;
  }
}
