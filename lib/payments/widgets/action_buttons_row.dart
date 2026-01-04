import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:securepay/common/widgets.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton(
          icon: Icons.send_rounded,
          label: 'Pay',
          color: const Color(0xFF1A237E),
          // Professional Routing: Navigate to the payment screen
          onTap: () => context.push('/send-payment'),
        ),
        ActionButton(
          icon: Icons.qr_code_2_rounded,
          label: 'Receive',
          color: Colors.teal,
          onTap: () => context.push('/receive-payment'),
        ),
        ActionButton(
          icon: Icons.fullscreen_rounded,
          label: 'Scan',
          color: const Color(0xFF1A237E),
          onTap: () => context.push("/qr-scanner"),
        ),
      ],
    );
  }
}
