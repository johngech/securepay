import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:securepay/payments/providers/payment_provider.dart';
import 'package:securepay/payments/widgets.dart';

class TransactionStatusScreen extends ConsumerWidget {
  final String amount;

  const TransactionStatusScreen({super.key, required this.amount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the real-time state of the payment process
    final paymentState = ref.watch(paymentNotifierProvider);

    return Scaffold(
      body: paymentState.when(
        loading: () => const ProcessingPaymentView(),
        data: (response) {
          if (response == null) return const ProcessingPaymentView();
          // Trigger the timed redirection
          _navigateToHistory(context, ref);

          return SuccessPaymentView(
            amount: amount,
            transactionCode: response.transactionCode,
          );
        },
        error: (error, stackTrace) =>
            PaymentFailedView(amount: amount, errorReason: error.toString()),
      ),
    );
  }

  void _navigateToHistory(BuildContext context, WidgetRef ref) {
    // Wait for 3-4 seconds so the user can read the Transaction ID
    Future.delayed(const Duration(seconds: 4), () {
      if (context.mounted) {
        // Reset the provider so the next time the user enters, it's fresh
        ref.read(paymentNotifierProvider.notifier).reset();

        context.go('/transaction-history');
      }
    });
  }
}
