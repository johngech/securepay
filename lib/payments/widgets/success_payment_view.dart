import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:securepay/common/themes.dart';

class SuccessPaymentView extends StatelessWidget {
  final String amount;
  const SuccessPaymentView({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.actionGreen,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(flex: 2),
          // Success Indicator
          const SuccessCheckmark(),
          const SizedBox(height: 32),
          const Text(
            'Payment Successful!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E),
            ),
          ),
          const Spacer(),
          // Central Amount
          Text(
            '\$$amount',
            style: const TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E),
            ),
          ),
          const Text(
            'Transaction ID: #TRX-992834',
            style: TextStyle(color: Colors.black54),
          ),
          const Spacer(flex: 2),
          // Done Button
          const DoneButton(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class SuccessCheckmark extends StatelessWidget {
  const SuccessCheckmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFE8F5E9),
        shape: BoxShape.circle,
      ),
      child:
          Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF00C853),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 60),
              )
              .animate()
              .scale(duration: 600.ms, curve: Curves.elasticOut)
              .rotate(duration: 600.ms, curve: Curves.elasticOut),
    );
  }
}

class DoneButton extends StatelessWidget {
  const DoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // Navigate back to Dashboard and clear stack
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A237E),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text('Back to Home', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
