import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wa_crm_mobile/core/network/api_exception.dart';
import 'package:wa_crm_mobile/features/auth/data/auth_repositry.dart';
import 'package:wa_crm_mobile/features/auth/presentation/controllers/auth_controller_state.dart';
part 'auth_controller.g.dart';

@riverpod
class  AuthController extends _$AuthController {
 AuthControllerState build() {
  return AuthControllerState. initial();
}  

late AuthRepository _authRepository;

Future<bool> signIn() async {       
   final params = {

   }

    try {
      final session = await _authRepository.login(params: params
        
      );

     return true;
     
    } on ApiException catch (e) {
           return true;

    }
  }



}
