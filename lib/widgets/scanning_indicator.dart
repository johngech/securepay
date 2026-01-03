import 'package:flutter/material.dart';

class ScanningIndicator extends StatefulWidget {
  const ScanningIndicator({super.key});

  @override
  State<ScanningIndicator> createState() => _ScanningIndicatorState();
}

class _ScanningIndicatorState extends State<ScanningIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Moves up and then back down

    _animation = Tween<double>(begin: 0, end: 260).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              top: _animation.value,
              left: 0,
              right: 0,
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00C853).withValues(alpha: 0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF00C853).withValues(alpha: 0),
                      const Color(0xFF00C853),
                      const Color(0xFF00C853).withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
