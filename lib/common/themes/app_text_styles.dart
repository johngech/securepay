import 'package:flutter/material.dart';
import 'package:securepay/common/themes/app_colors.dart';

class AppTextStyles {
  static const TextStyle header = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryBlue,
  );

  static const TextStyle subheader = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );
  static const TextStyle textLarge = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1A237E),
  );

  static const TextStyle errorText = TextStyle(
    fontSize: 16,
    color: Color(0xFFD32F2F),
  );
}
