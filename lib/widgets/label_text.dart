import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  const LabelText({
    required this.text,
    super.key,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.color = Colors.blueGrey,
  });
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
