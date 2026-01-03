import 'package:flutter/material.dart';

class ScannerFrame extends StatelessWidget {
  const ScannerFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ScannerFramePainter(),
      child: const SizedBox(height: 260, width: 260),
    );
  }
}

class _ScannerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
          const Color(0xFF00C853) // The neon green from your image
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const double cornerSize = 40.0;
    const double radius = 20.0;

    final path = Path();

    // --- TOP LEFT ---
    path.moveTo(0, cornerSize);
    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(cornerSize, 0);

    // --- TOP RIGHT ---
    path.moveTo(size.width - cornerSize, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, cornerSize);

    // --- BOTTOM RIGHT ---
    path.moveTo(size.width, size.height - cornerSize);
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );
    path.lineTo(size.width - cornerSize, size.height);

    // --- BOTTOM LEFT ---
    path.moveTo(cornerSize, size.height);
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);
    path.lineTo(0, size.height - cornerSize);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
