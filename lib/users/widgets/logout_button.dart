import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        // Logic: ref.read(authProvider.notifier).logout();
      },
      icon: const Icon(Icons.logout_rounded, color: Color(0xFFD32F2F)),
      label: const Text(
        "Logout Account",
        style: TextStyle(color: Color(0xFFD32F2F), fontWeight: FontWeight.bold),
      ),
    ).animate().fadeIn(delay: 500.ms);
  }
}
