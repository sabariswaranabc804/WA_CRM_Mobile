import 'dart:convert';

import 'package:wa_crm_mobile/core/constants/api_endpoints.dart';
import 'package:wa_crm_mobile/core/network/api_client.dart';
import 'package:wa_crm_mobile/core/network/api_exception.dart';
import 'package:wa_crm_mobile/core/storage/token_storage.dart';
import 'package:wa_crm_mobile/features/auth/domain/models/auth_model.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  AuthRepository({
    required ApiClient apiClient,
    required TokenStorage tokenStorage,
  })  : _apiClient = apiClient,
        _tokenStorage = tokenStorage;





       

  Future<AuthModel> login({

    required params
  }) async {
    final response = await _apiClient.postApiConnection(
     url: ApiEndpoints.login,
     params: params,
     requiresAuth: false
    );

  final result =   AuthModel.fromJson(jsonDecode(response));  

  if (!result.success) {
      throw ApiException(result.message);

  }
   await _tokenStorage.saveTokens(
      accessToken: result.data.accessToken,
      refreshToken: result.data.refreshToken,
    );
  return result ;
  }

  Future<void> logout() async {
    await _tokenStorage.clearTokens();
  }
}
