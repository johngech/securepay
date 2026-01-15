import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:securepay/auth/token_storage.dart';
import 'package:securepay/common/services/services.dart';

class AuthService {
  final Dio dio;
  final Ref ref;
  AuthService({required this.dio, required this.ref});

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      final String token = response.data['token'];
      await TokenStorage.saveToken(token);

      return response.data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Login failed';
    }
  }

  Future<void> logout() async {
    // 1. Clear the token from encrypted storage
    await TokenStorage.clearToken();

    // 2. Invalidate the Dio instance (optional, but good for security)
    ref.invalidate(dioProvider);

    // 3. Reset any form providers
    ref.invalidate(loginFormProvider);
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthService(dio: dio, ref: ref);
});

// A StateNotifier or AsyncNotifier to handle the loading state
final authControllerProvider = StateProvider<bool>((ref) => false);

final loginFormProvider = Provider.autoDispose((ref) {
  return fb.group({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(8)],
    ),
    'rememberMe': FormControl<bool>(value: false),
  });
});
