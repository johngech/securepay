import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:securepay/common/widgets.dart';
import 'package:securepay/security/widgets.dart';
import 'package:securepay/users/widgets.dart';

class ChangePinScreen extends ConsumerWidget {
  const ChangePinScreen({super.key});

  FormGroup _buildPinForm() => fb.group(
    {
      'oldPin': FormControl<String>(
        validators: [
          Validators.required,
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
                        ? () => _handlePinUpdate(context, form.value)
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

  void _handlePinUpdate(BuildContext context, Map<String, dynamic> data) {
    // Logic: ref.read(securityProvider.notifier).updatePin(data['newPin']);
  }
}
