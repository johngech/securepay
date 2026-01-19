import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:securepay/payments/providers/payment_method.dart';
import 'package:securepay/payments/providers/payment_provider.dart';
import 'package:securepay/common/themes.dart';
import 'package:securepay/payments/entities/payment_method.dart';
import 'package:securepay/payments/providers/resolve_receiver_provider.dart';
import 'package:securepay/payments/widgets.dart';
import 'package:securepay/common/widgets.dart';

class SendPaymentScreen extends ConsumerStatefulWidget {
  const SendPaymentScreen({super.key});

  @override
  ConsumerState<SendPaymentScreen> createState() => _SendPaymentScreenState();
}

class _SendPaymentScreenState extends ConsumerState<SendPaymentScreen> {
  late TextEditingController _recipientController;
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _recipientController = TextEditingController();
    _amountController = TextEditingController(text: '0.00');
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // Helper to safely parse amount
  double _getCleanAmount() {
    return double.tryParse(_amountController.text.replaceAll(',', '')) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final selectedMethod = ref.watch(selectedPaymentProvider);
    final recipientState = ref.watch(recipientLookupProvider);
    final stripeState = ref.watch(paymentNotifierProvider);

    // Listen for Stripe Success/Failure
    ref.listen(paymentNotifierProvider, (previous, next) {
      if (next.isLoading) {
        context.push("/transaction-status", extra: _amountController.text);
      }
    });

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
            AmountInput(controller: _amountController, balance: '15234.56'),
            const SizedBox(height: 24),

            const LabelText(text: 'Recipient'),

            RecipientField(
              controller: _recipientController,
              isVerified: recipientState.user != null,
              isValidating: recipientState.isValidating,
              verifiedName: recipientState.user?.fullName ?? '',
              errorText: recipientState.errorMessage,
              onChanged: (val) => ref
                  .read(recipientLookupProvider.notifier)
                  .onInputChanged(val),
              onContactTap: () {},
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
              label: stripeState.isLoading ? "Processing..." : "Continue",
              onPressed:
                  (recipientState.user == null ||
                      _getCleanAmount() <= 0 ||
                      stripeState.isLoading)
                  ? null
                  : () {
                      final String amountText = _amountController.text;
                      // final double amount = _getCleanAmount();
                      // if (selectedMethod == PaymentType.stripe) {
                      //   ref
                      //       .read(paymentNotifierProvider.notifier)
                      //       .processTopUp(amount);
                      // } else {
                      //   // context.push("/confirm-payment");
                      context.push("/pin-entry", extra: amountText);
                      // }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
