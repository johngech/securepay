import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginOptionsRow extends StatelessWidget {
  const LoginOptionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ReactiveCheckbox(
              formControlName: 'rememberMe',
              activeColor: const Color(0xFF1A237E),
            ),
            const Text("Remember me", style: TextStyle(fontSize: 14)),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Forgot Password?",
            style: TextStyle(
              color: Color(0xFF1A237E),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
