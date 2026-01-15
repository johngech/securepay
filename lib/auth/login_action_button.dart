import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:securepay/auth/auth_providers.dart';
import 'package:securepay/common/themes.dart';

class LoginActionButton extends ConsumerWidget {
  const LoginActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    final form = ref.watch(loginFormProvider);

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: AppColors.bgGrey,
        ),
        onPressed: isLoading ? null : () => _handleLogin(context, ref, form),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Login', style: TextStyle(fontSize: 18)),
      ),
    );
  }

  Future<void> _handleLogin(
    BuildContext context,
    WidgetRef ref,
    FormGroup form,
  ) async {
    if (form.valid) {
      ref.read(authControllerProvider.notifier).state = true;

      try {
        final email = form.control('email').value;
        final password = form.control('password').value;

        await ref.read(authServiceProvider).login(email, password);

        // Success: Navigate to home screen
        if (context.mounted) {
          context.push("/transaction-dashboard");
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
          );
        }
      } finally {
        ref.read(authControllerProvider.notifier).state = false;
      }
    } else {
      form.markAllAsTouched();
    }
  }
}
