import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileAvatarSection extends StatelessWidget {
  const ProfileAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.person, size: 60, color: Colors.grey),
          ).animate().shimmer(duration: 1.seconds),
          Positioned(
            bottom: 0,
            right: 4,
            child: CircleAvatar(
              backgroundColor: const Color(0xFF1A237E),
              radius: 18,
              child: IconButton(
                icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
