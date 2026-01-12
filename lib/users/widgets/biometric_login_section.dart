import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BiometricLoginSection extends StatelessWidget {
  const BiometricLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "Or login with",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 20),
          IconButton(
                icon: const Icon(
                  Icons.face_unlock_rounded,
                  size: 48,
                  color: Color(0xFF1A237E),
                ),
                onPressed: () {}, // Trigger Local Auth (FaceID/Fingerprint)
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .shimmer(
                duration: 2.seconds,
                color: Colors.blue.withValues(alpha: 0.2),
              ),
        ],
      ),
    );
  }
}
