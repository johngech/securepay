import 'package:flutter/material.dart';

class PaymentFailedView extends StatelessWidget {
  final String amount;
  final String errorReason;

  const PaymentFailedView({
    super.key,
    required this.amount,
    required this.errorReason,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(flex: 2),
          // 1. Error Indicator
          const FailureIndicator(),
          const SizedBox(height: 32),
          const Text(
            'Payment Failed',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD32F2F), // Red color for error
            ),
          ),
          const SizedBox(height: 12),
          // 2. Error Reason Text
          Text(
            errorReason,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          ),
          const Spacer(),
          // 3. Central Amount (Strikethrough or Dimmed)
          Text(
            '\$$amount',
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A237E).withValues(alpha: 0.5),
            ),
          ),
          const Spacer(flex: 2),
          // 4. Action Buttons
          const RetryButton(),
          const SizedBox(height: 12),
          const CancelButton(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class FailureIndicator extends StatelessWidget {
  const FailureIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFFFEBEE), // Light red background
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFFD32F2F), // Dark red circle
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.close, color: Colors.white, size: 60),
      ),
    );
  }
}

class RetryButton extends StatelessWidget {
  const RetryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // Typically pop back to the Confirm Payment screen to try again
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A237E),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text('Try Again', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        onPressed: () {
          // Go all the way back to the home/dashboard
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: const Text(
          'Cancel & Go Home',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
    );
  }
}
