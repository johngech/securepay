import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:securepay/users/providers.dart';
import 'package:securepay/users/widgets.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(loginFormProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ReactiveForm(
          formGroup: form,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const LoginHeader(),
                const SizedBox(height: 48),
                const UserFormInput(
                  formControlName: 'email',
                  label: 'Email Address',
                  icon: Icons.alternate_email_rounded,
                ),
                const UserFormInput(
                  formControlName: 'password',
                  label: 'Password',
                  icon: Icons.lock_outline_rounded,
                  isPassword: true,
                ),
                const LoginOptionsRow(),
                const SizedBox(height: 32),
                const LoginActionButton(),
                const SizedBox(height: 24),
                const BiometricLoginSection(),
                const SizedBox(height: 40),
                const RegisterRedirectSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}