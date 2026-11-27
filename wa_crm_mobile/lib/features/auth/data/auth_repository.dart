import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wa_crm_mobile/core/constants/api_endpoints.dart';
import 'package:wa_crm_mobile/core/network/api_client.dart';
import 'package:wa_crm_mobile/core/network/api_client_provider.dart';
import 'package:wa_crm_mobile/core/network/api_exception.dart';
import 'package:wa_crm_mobile/core/storage/token_storage.dart';
import 'package:wa_crm_mobile/core/storage/token_storage_provider.dart';
import 'package:wa_crm_mobile/core/utils/formatters.dart';
import 'package:wa_crm_mobile/features/auth/domain/models/auth_model.dart';
import 'package:wa_crm_mobile/features/auth/domain/models/login_params.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final client = ref.watch(apiClientProvider);
  final storage = ref.watch(tokenStorageProvider);
  return AuthRepository(apiClient: client, tokenStorage: storage);
}

class AuthRepository {
  final ApiClient apiClient;
  final TokenStorage tokenStorage;

  AuthRepository({
    required this.apiClient,
    required this.tokenStorage,
  });

  Future<AuthModel> login({required LoginParams params}) async {
    try {
      final response = await apiClient.postApiConnection(
        url: ApiEndpoints.login,
        params: {
          'tenantSlug': slugify(params.workspace),
          'email': params.email.trim(),
          'password': params.password,
        },
        requiresAuth: false,
      );

      final Map<String, dynamic> resMap = response is Map<String, dynamic>
          ? response
          : (response is Map
              ? Map<String, dynamic>.from(response)
              : jsonDecode(response.toString()) as Map<String, dynamic>);

      final AuthModel authModel;
      if (resMap.containsKey('data') && resMap['data'] is Map) {
        authModel = AuthModel.fromJson(resMap);
      } else {
        final sessionData = AuthModelData.fromJson(resMap);
        authModel = AuthModel(
          success: true,
          message: 'Login successful',
          data: sessionData,
        );
      }

      await tokenStorage.saveTokens(
        accessToken: authModel.data.accessToken,
        refreshToken: authModel.data.refreshToken,
      );
      await tokenStorage.saveLoginHints(
        slug: params.workspace,
        email: params.email.trim(),
      );

      return authModel;
    } on ApiException {
      rethrow;
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<void> logout() async {
    final refreshToken = await tokenStorage.getRefreshToken();
    if (refreshToken != null && refreshToken.isNotEmpty) {
      try {
        await apiClient.postApiConnection(
          url: ApiEndpoints.logout,
          params: {'refreshToken': refreshToken},
        );
      } catch (_) {}
    }
    await tokenStorage.clearTokens();
  }
}
