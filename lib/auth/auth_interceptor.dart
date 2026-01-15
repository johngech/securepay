import 'package:dio/dio.dart';
import 'package:securepay/auth/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio; // Pass dio instance to perform the refresh request

  AuthInterceptor(this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await TokenStorage.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // If we get a 401, the token might be expired
    if (err.response?.statusCode == 401) {
      final success = await _refreshToken();

      if (success) {
        // Retry the original request with the new token
        return handler.resolve(await _retry(err.requestOptions));
      } else {
        // Refresh failed (e.g. refresh token also expired)
        await TokenStorage.clearToken();
        // Trigger a logout event (e.g. via an EventBus or Provider)
      }
    }
    return handler.next(err);
  }

  Future<bool> _refreshToken() async {
    try {
      // that takes a refresh token or uses a secure cookie.
      final response = await _dio.post('/auth/refresh');
      final newToken = response.data['token'];

      await TokenStorage.saveToken(newToken);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
