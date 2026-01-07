import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:securepay/common/widgets.dart';
import 'package:securepay/payments/providers.dart';
import 'package:securepay/payments/widgets.dart';
import 'package:securepay/users/widgets.dart';

class StripeAccountCard extends StatelessWidget {
  const StripeAccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return PaymentAccountContainer(
      headerColor: const Color(0xFF635BFF), // Stripe Purple
      logo: const Icon(Icons.credit_card, color: Colors.white),
      title: 'Stripe',
      isDefault: true,
      child: Column(
        children: const [
          CreditCardItem(lastFour: '4242', expiry: '12/25'),
          Divider(height: 1),
          CreditCardItem(lastFour: '5555', expiry: '08/26'),
          SizedBox(height: 12),
          SecondaryActionButton(label: 'Disconnect'),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}
class PayPalAccountCard extends ConsumerWidget {
  const PayPalAccountCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(paypalFormProvider);

    return PaymentAccountContainer(
      headerColor: const Color(0xFF0070BA), // PayPal Blue
      logo: const Icon(Icons.paypal, color: Colors.white, size: 28),
      title: 'PayPal',
      child: ReactiveForm(
        formGroup: form,
        child: Column(
          children: [
            const UserFormInput(
              formControlName: 'paypal_email',
              label: 'PayPal Email Address',
              icon: Icons.alternate_email,
            ),
            const SizedBox(height: 8),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                return Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        label: 'Set as Default',
                        // Button is only active if the email is valid
                        onPressed: form.valid 
                          ? () => debugPrint("Updating PayPal: ${form.value}") 
                          : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: SecondaryActionButton(label: 'Disconnect'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.1, delay: 100.ms);
  }
}

class RazorparyAccountCard extends ConsumerWidget {
  const RazorparyAccountCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(razorpayFormProvider);

    return PaymentAccountContainer(
      headerColor: const Color(0xFF3395FF), // Razorpay Blue
      logo: const Icon(Icons.diamond_outlined, color: Colors.white, size: 28),
      title: 'Razorpay',
      child: ReactiveForm(
        formGroup: form,
        child: Column(
          children: [
            const UserFormInput(
              formControlName: 'razorpay_id',
              label: 'Merchant ID',
              icon: Icons.account_balance_wallet_outlined,
            ),
            const SizedBox(height: 8),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                return Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        label: 'Set as Default',
                        onPressed: form.valid ? () {} : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: SecondaryActionButton(label: 'Disconnect'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.1, delay: 200.ms);
  }
}