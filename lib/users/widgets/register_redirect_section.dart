import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class RegisterRedirectSection extends StatelessWidget {
  const RegisterRedirectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
            ),
            TextButton(
              onPressed: () =>
                  context.push('/users/register'), // GoRouter navigation
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Color(0xFF1A237E),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: 800.ms),
    );
  }
}
