
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<dynamic> getApiConnection({
    required String url,
    bool requiresAuth = true,
  }) async {
    final response = await _dio.get(
      url,
      options: Options(
        extra: {
          'requiresAuth': requiresAuth,
        },
      ),
    );

    return response.data;
  }

  Future<dynamic> postApiConnection({
    required String url,
    required dynamic params,
    bool requiresAuth = true,
  }) async {
    final response = await _dio.post(
      url,
      data: params,
      options: Options(
        extra: {
          'requiresAuth': requiresAuth,
        },
      ),
    );

    return response.data;
  }

  Future<dynamic> putApiConnection({
    required String url,
    required dynamic params,
    bool requiresAuth = true,
  }) async {
    final response = await _dio.put(
      url,
      data: params,
      options: Options(
        extra: {
          'requiresAuth': requiresAuth,
        },
      ),
    );

    return response.data;
  }

  Future<dynamic> deleteApiConnection({
    required String url,
    bool requiresAuth = true,
  }) async {
    final response = await _dio.delete(
      url,
      options: Options(
        extra: {
          'requiresAuth': requiresAuth,
        },
      ),
    );

    return response.data;
  }
}
