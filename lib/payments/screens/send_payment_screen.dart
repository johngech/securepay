import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:securepay/payments/providers/payment_method.dart';
import 'package:securepay/payments/providers/payment_provider.dart';
import 'package:securepay/common/themes.dart';
import 'package:securepay/payments/entities/payment_method.dart';
import 'package:securepay/payments/widgets.dart';
import 'package:securepay/common/widgets.dart';

class SendPaymentScreen extends ConsumerStatefulWidget {
  const SendPaymentScreen({super.key});

  @override
  ConsumerState<SendPaymentScreen> createState() => _SendPaymentScreenState();
}

class _SendPaymentScreenState extends ConsumerState<SendPaymentScreen> {
  late TextEditingController _recipientController;

  @override
  void initState() {
    super.initState();
    _recipientController = TextEditingController();
  }

  @override
  void dispose() {
    _recipientController.dispose(); // Critical: prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedMethod = ref.watch(selectedPaymentProvider);

    final paymentState = ref.watch(paymentProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Send Payment',
          style: TextStyle(color: AppColors.primaryBlue),
        ),
        centerTitle: true,
        leading: const BackButton(color: AppColors.primaryBlue),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LabelText(text: 'Amount'),
            const AmountInput(balance: '15234.56'),
            const SizedBox(height: 24),

            const LabelText(text: 'Recipient'),

            RecipientField(
              controller: _recipientController,
              isVerified: paymentState.isVerified,
              isValidating: paymentState.isValidating,
              verifiedName: paymentState.verifiedName,
              errorText: paymentState.errorMessage,
              onChanged: (val) =>
                  ref.read(paymentProvider.notifier).onRecipientChanged(val),
              onContactTap: () {
                // Future feature: Open Phone Contacts
              },
            ),

            const SizedBox(height: 24),
            const LabelText(text: 'Payment Method'),
            ...[
              PaymentMethodCard(
                method: const PaymentMethod(
                  type: PaymentType.stripe,
                  title: 'Stripe Card',
                  subtitle: '•••• 4242',
                  icon: Icons.credit_card,
                ),
                isSelected: selectedMethod == PaymentType.stripe,
                onTap: () => ref.read(selectedPaymentProvider.notifier).state =
                    PaymentType.stripe,
              ),
              PaymentMethodCard(
                method: const PaymentMethod(
                  type: PaymentType.paypal,
                  title: 'PayPal',
                  subtitle: '•••• john@',
                  icon: Icons.payment,
                ),
                isSelected: selectedMethod == PaymentType.paypal,
                onTap: () => ref.read(selectedPaymentProvider.notifier).state =
                    PaymentType.paypal,
              ),
              PaymentMethodCard(
                method: const PaymentMethod(
                  type: PaymentType.bank,
                  title: 'Bank Account',
                  subtitle: '•••• 8901',
                  icon: Icons.account_balance,
                ),
                isSelected: selectedMethod == PaymentType.bank,
                onTap: () => ref.read(selectedPaymentProvider.notifier).state =
                    PaymentType.bank,
              ),
            ],

            AppButton(
              label: "Continue",
              onPressed: () => context.push("/confirm-payment"),
            ),
          ],
        ),
      ),
    );
  }
}
