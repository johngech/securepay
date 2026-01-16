import 'package:flutter/material.dart';
import 'package:securepay/settings/widgets.dart';

class AuthenticationList extends StatelessWidget {
  const AuthenticationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: const [
          AuthTile(
            icon: Icons.face_retouching_natural,
            label: 'Biometric (Face ID)',
          ),
          Divider(height: 1),
          AuthTile(icon: Icons.dialpad, label: '6-Digit PIN'),
          Divider(height: 1),
          AuthTile(icon: Icons.qr_code_scanner, label: 'QR Code Payments'),
        ],
      ),
    );
  }
}
