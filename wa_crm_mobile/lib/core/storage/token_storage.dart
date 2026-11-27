import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wa_crm_mobile/core/storage/local_storage_keys.dart';

class TokenStorage {
  final FlutterSecureStorage _storage;

  TokenStorage([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      _storage.write(key: LocalStorageKeys.accessToken, value: accessToken),
      _storage.write(key: LocalStorageKeys.refreshToken, value: refreshToken),
    ]);
  }

  Future<String?> getAccessToken() {
    return _storage.read(key: LocalStorageKeys.accessToken);
  }

  Future<String?> getRefreshToken() {
    return _storage.read(key: LocalStorageKeys.refreshToken);
  }

  Future<void> saveLoginHints({
    required String slug,
    required String email,
  }) async {
    await Future.wait([
      _storage.write(key: LocalStorageKeys.tenantSlug, value: slug),
      _storage.write(key: LocalStorageKeys.lastEmail, value: email),
    ]);
  }

  Future<String?> getTenantSlug() {
    return _storage.read(key: LocalStorageKeys.tenantSlug);
  }

  Future<String?> getLastEmail() {
    return _storage.read(key: LocalStorageKeys.lastEmail);
  }

  Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: LocalStorageKeys.accessToken),
      _storage.delete(key: LocalStorageKeys.refreshToken),
    ]);
  }
}
