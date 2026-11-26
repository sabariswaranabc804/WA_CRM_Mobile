import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

/// Server connection configuration.
class AppConfig {
  static const String _compileTimeBaseUrl = String.fromEnvironment('API_BASE_URL');

  static String? _runtimeBaseUrl;

  static String get defaultBaseUrl {
    if (_compileTimeBaseUrl.isNotEmpty) return _compileTimeBaseUrl;
    if (!kIsWeb && Platform.isAndroid) return 'http://10.0.2.2:3001/api/v1';
    return 'http://localhost:3001/api/v1';
  }

  static String get apiBaseUrl => _runtimeBaseUrl ?? defaultBaseUrl;

  static void setRuntimeBaseUrl(String? url) {
    final trimmed = url?.trim();
    _runtimeBaseUrl = (trimmed == null || trimmed.isEmpty) ? null : trimmed;
  }
}
