import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmPaymentScreen extends StatelessWidget {
  final String amount;
  final String recipient;
  final String paymentMethod;

  const ConfirmPaymentScreen({
    super.key,
    required this.amount,
    required this.recipient,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ConfirmPaymentAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  AmountDisplayCard(amount: amount),
                  const SizedBox(height: 24),
                  PaymentDetailTile(
                    label: 'To',
                    value: recipient,
                    icon: Icons.person_outline,
                    iconBg: const Color(0xFFE8EAF6),
                  ),
                  const SizedBox(height: 16),
                  PaymentDetailTile(
                    label: 'Payment Method',
                    value: paymentMethod,
                    icon: Icons.credit_card,
                    iconBg: const Color(0xFFE8F5E9),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: BiometricAuthButton(
              onPressed: () => context.push("/transaction-status"),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmPaymentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ConfirmPaymentAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackButton(color: Color(0xFF1A237E)),
      title: const Text(
        'Confirm Payment',
        style: TextStyle(color: Color(0xFF1A237E), fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AmountDisplayCard extends StatelessWidget {
  final String amount;
  const AmountDisplayCard({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: const Color(0xFF283593),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text(
            'You\'re paying',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            '\$$amount',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const SecuredIndicator(),
        ],
      ),
    );
  }
}

class SecuredIndicator extends StatelessWidget {
  const SecuredIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.check, color: Color(0xFF00C853), size: 16),
        SizedBox(width: 4),
        Text('Secured', style: TextStyle(color: Color(0xFF00C853))),
      ],
    );
  }
}

class PaymentDetailTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconBg;

  const PaymentDetailTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconBg,
            child: Icon(icon, color: const Color(0xFF283593)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BiometricAuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  const BiometricAuthButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.fingerprint),
        label: const Text('Authenticate & Pay', style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00C853),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
