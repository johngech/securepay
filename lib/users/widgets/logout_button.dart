import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:securepay/auth/auth_providers.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      onPressed: () {
        ref.watch(authServiceProvider).logout();
        if (context.mounted) {
          context.go("/login");
        }
      },
      icon: const Icon(Icons.logout_rounded, color: Color(0xFFD32F2F)),
      label: const Text(
        "Logout Account",
        style: TextStyle(color: Color(0xFFD32F2F), fontWeight: FontWeight.bold),
      ),
    ).animate().fadeIn(delay: 500.ms);
  }
}
