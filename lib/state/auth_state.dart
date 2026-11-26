import 'package:flutter/foundation.dart';

import '../core/api_client.dart';
import '../core/config.dart';
import '../models/session.dart';
import 'app_services.dart';

enum AuthStatus { checking, signedOut, signedIn }

/// Owns the session: restores it on launch, signs in and out, and tells the
/// router which shell to show.
class AuthState extends ChangeNotifier {
  final AppServices services;

  AuthStatus _status = AuthStatus.checking;
  AuthUser? _user;
  Tenant? _tenant;
  String? _error;
  bool _busy = false;

  AuthState(this.services) {
    // A refresh that fails deep inside a screen must still land the user back
    // on the login screen.
    services.api.onAuthFailure = _forceSignOut;
  }

  AuthStatus get status => _status;
  AuthUser? get user => _user;
  Tenant? get tenant => _tenant;
  String? get error => _error;
  bool get busy => _busy;

  /// Loads any saved server URL, then tries the stored token.
  Future<void> bootstrap() async {
    final savedUrl = await services.storage.readBaseUrl();
    AppConfig.setRuntimeBaseUrl(savedUrl);
    services.api.syncBaseUrl();

    final token = await services.storage.readAccessToken();
    if (token == null) {
      _set(AuthStatus.signedOut);
      return;
    }

    try {
      final me = await services.auth.me();
      _user = me.user;
      _tenant = me.tenant;
      _set(AuthStatus.signedIn);
    } on ApiException {
      // Includes the case where the refresh token is also dead.
      await services.storage.clearTokens();
      _set(AuthStatus.signedOut);
    }
  }

  Future<bool> signIn({
    required String workspace,
    required String email,
    required String password,
  }) async {
    _busy = true;
    _error = null;
    notifyListeners();

    try {
      final session = await services.auth.login(
        workspace: workspace,
        email: email,
        password: password,
      );

      await services.storage.saveTokens(
        accessToken: session.accessToken,
        refreshToken: session.refreshToken,
      );
      await services.storage.saveLoginHints(slug: workspace, email: email);

      _user = session.user;
      _tenant = session.tenant;
      _busy = false;
      _set(AuthStatus.signedIn);
      return true;
    } on ApiException catch (e) {
      _error = e.message;
      _busy = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    final refreshToken = await services.storage.readRefreshToken();
    await services.auth.logout(refreshToken);
    await services.storage.clearTokens();
    _user = null;
    _tenant = null;
    _set(AuthStatus.signedOut);
  }

  /// Applies a new server URL and drops the session, since tokens are only
  /// valid against the server that issued them.
  Future<void> changeServerUrl(String? url) async {
    await services.storage.saveBaseUrl(url);
    AppConfig.setRuntimeBaseUrl(url);
    services.api.syncBaseUrl();
    await services.storage.clearTokens();
    _user = null;
    _tenant = null;
    _set(AuthStatus.signedOut);
  }

  void clearError() {
    if (_error == null) return;
    _error = null;
    notifyListeners();
  }

  void _forceSignOut() {
    services.storage.clearTokens();
    _user = null;
    _tenant = null;
    _set(AuthStatus.signedOut);
  }

  void _set(AuthStatus next) {
    _status = next;
    notifyListeners();
  }
}
