import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Welcome Back",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
            letterSpacing: -1,
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
        const SizedBox(height: 8),
        const Text(
          "Securely sign in to your SecurePay account",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ).animate().fadeIn(delay: 200.ms),
      ],
    );
  }
}
