import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:securepay/common/widgets.dart';
import 'package:securepay/settings/widgets.dart';
import 'package:securepay/users/user_providers.dart';
import 'package:securepay/users/widgets.dart';

class ChangePinScreen extends ConsumerWidget {
  const ChangePinScreen({super.key});

  FormGroup _buildPinForm() => fb.group(
    {
      'oldPin': FormControl<String>(
        validators: [
          // Validators.required,
          Validators.minLength(6),
          Validators.maxLength(6),
        ],
      ),
      'newPin': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(6),
          Validators.maxLength(6),
        ],
      ),
      'confirmPin': FormControl<String>(validators: [Validators.required]),
    },
    [Validators.mustMatch('newPin', 'confirmPin')],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(pinUpdateProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          // SUCCESS: Show toast and go back
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('PIN updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );

          // OPTION A: Go back to settings
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/users'); // Fallback
          }
        },
        error: (err, _) {
          // FAILURE: Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Update failed: $err'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SettingsAppBar(title: 'Update Security PIN'),
      body: ReactiveFormBuilder(
        form: _buildPinForm,
        builder: (context, form, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: "Secure Your Account",
                  subtitle: "Enter your current and new 6-digit PIN",
                ),
                const SizedBox(height: 32),
                const UserFormInput(
                  formControlName: 'oldPin',
                  label: 'Current PIN',
                  icon: Icons.lock_person_outlined,
                  isPassword: true,
                ),
                const UserFormInput(
                  formControlName: 'newPin',
                  label: 'New 6-Digit PIN',
                  icon: Icons.vibration_outlined,
                  isPassword: true,
                ),
                const UserFormInput(
                  formControlName: 'confirmPin',
                  label: 'Confirm New PIN',
                  icon: Icons.check_circle_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 32),
                ReactiveFormConsumer(
                  builder: (context, form, child) => PrimaryButton(
                    label: "Update PIN",
                    onPressed: form.valid
                        ? () => _handlePinUpdate(context, ref, form)
                        : null,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handlePinUpdate(BuildContext context, WidgetRef ref, FormGroup form) {
    // 1. Get the current user ID (assuming it's stored in a provider)

    final userAsync = ref.read(currentUserProvider);
    userAsync.when(
      data: (user) {
        // 2. Execute update with the real ID from /auth/me
        ref
            .read(pinUpdateProvider.notifier)
            .updatePin(
              userId: user.id,
              oldPin: form.control('oldPin').value as String?,
              newPin: form.control('newPin').value as String,
            );
      },
      loading: () => null, // Button is already disabled via isLoading check
      error: (err, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not verify user session')),
        );
      },
    );
  }
}
