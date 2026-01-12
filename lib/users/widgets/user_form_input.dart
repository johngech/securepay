import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_animate/flutter_animate.dart';

class UserFormInput extends StatelessWidget {
  final String formControlName;
  final String label;
  final IconData icon;
  final bool isPassword;
  final Map<String, String Function(Object)>? validationMessages;

  const UserFormInput({
    super.key,
    required this.formControlName,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.validationMessages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ReactiveTextField<String>(
        formControlName: formControlName,
        obscureText: isPassword,
        validationMessages: validationMessages,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF1A237E), size: 20),
          filled: true,
          fillColor: const Color(0xFFF5F7FA),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF1A237E), width: 1),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0);
  }
}
