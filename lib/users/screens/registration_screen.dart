import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:securepay/users/user_providers.dart';
import 'package:securepay/users/widgets.dart';

class RegistrationScreen extends ConsumerWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(registrationFormProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
      ),
      body: ReactiveForm(
        formGroup: form,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Start your secure journey with SecurePay",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              const UserFormInput(
                formControlName: 'firstName',
                label: 'First Name',
                icon: Icons.person_outline,
              ),
              const UserFormInput(
                formControlName: 'lastName',
                label: 'Last Name',
                icon: Icons.person_outline,
              ),
              const UserFormInput(
                formControlName: 'email',
                label: 'Email Address',
                icon: Icons.email_outlined,
              ),
              const UserFormInput(
                formControlName: 'phoneNumber',
                label: 'Phone Number',
                icon: Icons.phone,
              ),
              const UserFormInput(
                formControlName: 'password',
                label: 'Password',
                icon: Icons.lock_outline,
                isPassword: true,
              ),
              const UserFormInput(
                formControlName: 'confirmPassword',
                label: 'Confirm Password',
                icon: Icons.lock_reset,
                isPassword: true,
              ),
              const SizedBox(height: 24),
              RegisterActionButton(),
            ],
          ),
        ),
      ),
    );
  }
}
