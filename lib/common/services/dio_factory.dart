import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:securepay/auth/auth_interceptor.dart';

class DioFactory {
  static Dio create() {
    final baseUrl = dotenv.get(
      'BASE_URL',
      fallback: 'http://localhost:8080/api',
    );

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add our smart Auth Interceptor
    dio.interceptors.add(AuthInterceptor(dio));

    // Add logging for development
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    );

    return dio;
  }
}

final dioProvider = Provider<Dio>((ref) => DioFactory.create());
