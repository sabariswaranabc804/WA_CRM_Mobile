import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wa_crm_mobile/core/storage/local_storage_keys.dart';

class TokenStorage {
  final FlutterSecureStorage _storage;

  TokenStorage(this._storage);

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

  Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: LocalStorageKeys.accessToken),
      _storage.delete(key: LocalStorageKeys.refreshToken),
    ]);
  }
}
