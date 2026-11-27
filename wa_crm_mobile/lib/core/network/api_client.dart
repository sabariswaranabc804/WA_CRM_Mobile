import 'package:dio/dio.dart';
import 'api_exception.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<dynamic> getApiConnection({
    required String url,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          extra: {
            'requiresAuth': requiresAuth,
          },
        ),
      );

      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<dynamic> postApiConnection({
    required String url,
    required dynamic params,
    bool requiresAuth = true,
  }) async {
    try {
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
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<dynamic> putApiConnection({
    required String url,
    required dynamic params,
    bool requiresAuth = true,
  }) async {
    try {
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
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<dynamic> deleteApiConnection({
    required String url,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        options: Options(
          extra: {
            'requiresAuth': requiresAuth,
          },
        ),
      );

      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
