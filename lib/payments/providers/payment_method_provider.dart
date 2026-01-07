import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to manage the PayPal form state
final paypalFormProvider = Provider.autoDispose((ref) {
  return fb.group({
    'paypal_email': FormControl<String>(
      value: 'john@example.com', // Initial value from domain entity
      validators: [Validators.required, Validators.email],
    ),
  });
});

// Provider to manage the Razorpay form state
final razorpayFormProvider = Provider.autoDispose((ref) {
  return fb.group({
    'razorpay_id': FormControl<String>(
      value: 'rzp_live_12345',
      validators: [Validators.required],
    ),
  });
});