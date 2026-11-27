import 'dart:developer' as developer;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wa_crm_mobile/core/network/api_exception.dart';
import 'package:wa_crm_mobile/features/auth/data/auth_repository.dart';
import 'package:wa_crm_mobile/features/auth/domain/models/login_params.dart';
import 'package:wa_crm_mobile/features/auth/presentation/controllers/auth_controller_state.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthControllerState build() {
    return AuthControllerState.initial();
  }

  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  Future<bool> signIn(LoginParams params) async {
    if (state.isLoading) return false;

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final session = await _authRepository.login(params: params);

      state = state.copyWith(
        authModel: session,
        isLoading: false,
        errorMessage: null,
      );

      return true;
    } on ApiException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      );
      return false;
    } catch (e, st) {
      developer.log(
        'Unexpected sign-in failure: $e',
        name: 'AUTH_CONTROLLER',
        error: e,
        stackTrace: st,
      );
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong. Please try again.',
      );
      return false;
    }
  }

  Future<void> signOut() async {
    await _authRepository.logout();
    state = AuthControllerState.initial();
  }
}
