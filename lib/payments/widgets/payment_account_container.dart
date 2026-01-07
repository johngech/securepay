import 'package:flutter/material.dart';

class PaymentAccountContainer extends StatelessWidget {
  final Color headerColor;
  final Widget logo;
  final String title;
  final bool isDefault;
  final Widget child;

  const PaymentAccountContainer({
    super.key,
    required this.headerColor,
    required this.logo,
    required this.title,
    this.isDefault = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: headerColor,
            child: Row(
              children: [
                logo,
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                if (isDefault)
                  const Icon(Icons.check_circle, color: Colors.white),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(16.0), child: child),
        ],
      ),
    );
  }
}

class SecurityDisclaimerNote extends StatelessWidget {
  const SecurityDisclaimerNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.lock_outline, size: 18, color: Color(0xFF1565C0)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'All payment information is encrypted and secured with bank-level security. SecurePay never stores your full card details.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF1565C0),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
