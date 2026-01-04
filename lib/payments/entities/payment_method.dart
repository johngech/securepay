import 'package:flutter/material.dart';

enum PaymentType { stripe, paypal, bank }

class PaymentMethod {
  final PaymentType type;
  final String title;
  final String subtitle;
  final IconData icon;

  const PaymentMethod({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
