import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wa_crm_mobile/features/auth/domain/models/auth_model.dart';


part 'auth_controller_state.freezed.dart';

@freezed
abstract class AuthControllerState with _$AuthControllerState {
  const factory AuthControllerState({
    required AuthModel? authModel,
    required bool isLoading,
    String? errorMessage,
  }) = _AuthControllerState;

  factory AuthControllerState.initial() {

    return const AuthControllerState(authModel: null ,isLoading: false);
  }
     
}