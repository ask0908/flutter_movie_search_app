import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_movie_search_app/core/constants/api_constants.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ApiConstants.bearerToken}',
        },
      ),
    );

    // 로깅 인터셉터
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (log) => debugPrint('[DIO] $log'),
      ),
    );

    // 에러 인터셉터
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, handler) {
          debugPrint('[DIO ERROR] : ${error.message}');
          debugPrint('[DIO ERROR DATA] : ${error.response?.data}');

          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
