import 'package:flutter/material.dart';

class ExpiryTimer extends StatelessWidget {
  final int seconds;
  const ExpiryTimer({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.access_time, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          'Expires in $minutes:$remainingSeconds',
          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
