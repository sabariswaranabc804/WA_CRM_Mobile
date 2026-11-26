
import 'package:dio/dio.dart';

import '../constants/api_endpoints.dart';
import '../storage/token_storage.dart';
import 'auth_interceptor.dart';

class DioClient {
  late final Dio dio;
  late final Dio refreshDio;

  DioClient({
    required TokenStorage tokenStorage,
    Future<void> Function()? onSessionExpired,
  }) {
    final options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    dio = Dio(options);

    // Separate Dio for refresh API.
    // It does not contain AuthInterceptor.
    refreshDio = Dio(options);

    dio.interceptors.add(
      AuthInterceptor(
        dio: dio,
        refreshDio: refreshDio,
        tokenStorage: tokenStorage,
        refreshUrl: ApiEndpoints.refreshToken,
        onSessionExpired: onSessionExpired,
      ),
    );
  }
}
