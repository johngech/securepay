import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:securepay/auth/auth_providers.dart'; // Adjust path
import 'package:securepay/common/widgets.dart';
import 'package:securepay/users/user_providers.dart';

class RegisterActionButton extends ConsumerWidget {
  const RegisterActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the global loading state
    final isLoading = ref.watch(authControllerProvider);

    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return PrimaryButton(
          label: isLoading ? "Creating Account..." : "Sign Up",
          // Disable button if form is invalid OR if currently loading
          onPressed: (form.valid && !isLoading)
              ? () => _onRegister(context, ref, form)
              : null,
        );
      },
    );
  }

  Future<void> _onRegister(
    BuildContext context,
    WidgetRef ref,
    FormGroup form,
  ) async {
    // Start loading
    ref.read(authControllerProvider.notifier).state = true;

    try {
      final userData = {
        'firstName': form.control("firstName").value,
        'lastName': form.control('lastName').value,
        'email': form.control('email').value,
        'phone': form.control("phoneNumber").value,
        'password': form.control('password').value,
      };

      await ref.read(userServiceProvider).create(userData);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Welcome! Registration Successful.')),
        );
        context.go("/transaction-dashboard");
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      // Stop loading
      ref.read(authControllerProvider.notifier).state = false;
    }
  }
}
