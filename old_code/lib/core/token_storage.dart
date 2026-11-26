import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// The only storage surface [TokenStorage] needs.
///
/// Depending on this rather than on `FlutterSecureStorage` directly keeps the
/// plugin's platform-option types out of the app, and lets tests substitute an
/// in-memory map instead of a keystore that does not exist under `flutter test`.
abstract class KeyValueStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

/// Production implementation, backed by the platform keystore/keychain.
class SecureKeyValueStore implements KeyValueStore {
  // The v10 defaults are already the hardened ones on both platforms —
  // AES-GCM with RSA-OAEP key wrapping in the Android keystore, and the
  // iOS keychain — so no options override is needed.
  final FlutterSecureStorage _storage;

  const SecureKeyValueStore([
    this._storage = const FlutterSecureStorage(),
  ]);

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}

/// In-memory store for tests.
class InMemoryKeyValueStore implements KeyValueStore {
  final Map<String, String> values = {};

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async => values[key] = value;

  @override
  Future<void> delete(String key) async => values.remove(key);
}

/// Persists the JWT pair plus the small set of preferences the app needs
/// before it can talk to a server: last workspace, last email, server URL and
/// theme.
///
/// The web client keeps tokens in httpOnly cookies; a mobile client cannot, so
/// it uses the bearer token the login response also returns and stores it in
/// the platform keystore.
class TokenStorage {
  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';
  static const _slugKey = 'tenant_slug';
  static const _emailKey = 'last_email';
  static const _baseUrlKey = 'api_base_url';
  static const _themeKey = 'theme';

  final KeyValueStore _store;

  TokenStorage([KeyValueStore? store])
      : _store = store ?? const SecureKeyValueStore();

  Future<String?> readAccessToken() => _store.read(_accessKey);
  Future<String?> readRefreshToken() => _store.read(_refreshKey);
  Future<String?> readTenantSlug() => _store.read(_slugKey);
  Future<String?> readLastEmail() => _store.read(_emailKey);
  Future<String?> readBaseUrl() => _store.read(_baseUrlKey);

  /// 'system' | 'light' | 'dark'. Shares the key name with the web client's
  /// `localStorage.theme`, though only this app reads it.
  Future<String?> readTheme() => _store.read(_themeKey);

  Future<void> saveTheme(String mode) => _store.write(_themeKey, mode);

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _store.write(_accessKey, accessToken);
    await _store.write(_refreshKey, refreshToken);
  }

  Future<void> saveAccessToken(String accessToken) =>
      _store.write(_accessKey, accessToken);

  Future<void> saveLoginHints({
    required String slug,
    required String email,
  }) async {
    await _store.write(_slugKey, slug);
    await _store.write(_emailKey, email);
  }

  Future<void> saveBaseUrl(String? url) async {
    final trimmed = url?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      await _store.delete(_baseUrlKey);
    } else {
      await _store.write(_baseUrlKey, trimmed);
    }
  }

  /// Clears credentials but keeps the workspace slug, email, server URL and
  /// theme so the next login screen is pre-filled and looks the same.
  Future<void> clearTokens() async {
    await _store.delete(_accessKey);
    await _store.delete(_refreshKey);
  }
}
