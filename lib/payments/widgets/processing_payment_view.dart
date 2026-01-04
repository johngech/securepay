import 'package:flutter/material.dart';

class ProcessingPaymentView extends StatelessWidget {
  const ProcessingPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              color: Color(0xFF00C853),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Processing Payment...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A237E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please do not close the app',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
