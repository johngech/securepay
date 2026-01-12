// presentation/providers/auth_form_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final registrationFormProvider = Provider.autoDispose((ref) {
  return fb.group(
    {
      'fullName': FormControl<String>(validators: [Validators.required]),
      'email': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)],
      ),
      'confirmPassword': FormControl<String>(),
    },
    [Validators.mustMatch('password', 'confirmPassword')],
  );
});
