import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:securepay/payments/providers/receive_payment_timer.dart';
import 'package:securepay/payments/widgets.dart';
import 'package:securepay/common/widgets.dart';

class ReceivePaymentScreen extends ConsumerWidget {
  const ReceivePaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerAsync = ref.watch(receiveTimerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Receive Payment',
          style: TextStyle(color: Color(0xFF1A237E)),
        ),
        centerTitle: true,
        leading: const BackButton(color: Color(0xFF1A237E)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const LabelText(text: 'Request Amount (Optional)'),
            const AmountInput(balance: ''),
            const SizedBox(height: 32),
            const QRCodeDisplay(data: 'securepay-user-123'),
            const SizedBox(height: 24),

            // Timer Display logic
            timerAsync.when(
              data: (seconds) => ExpiryTimer(seconds: seconds),
              loading: () => const CircularProgressIndicator.adaptive(),
              error: (_, __) => const Text('Timer Error'),
            ),

            const SizedBox(height: 16),
            const Text(
              'Show this QR code to receive payment or share it with the payer',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 40),
            const ActionButtonGroup(),
          ],
        ),
      ),
    );
  }
}
