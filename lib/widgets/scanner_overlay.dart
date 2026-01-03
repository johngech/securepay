import 'package:flutter/material.dart';
import 'package:securepay/widgets.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Darkened background with a hole in the middle
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.5),
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 260,
                  width: 260,
                  decoration: BoxDecoration(
                    color: Colors.red, // This color doesn't matter
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Neon Corners
        Center(
          child: SizedBox(
            height: 260,
            width: 260,
            child: Stack(
              children: [
                const ScannerFrame(), // The neon corners we built earlier
                const ScanningIndicator(), // The new animated laser line
              ],
            ),
          ),
        ),
        const Positioned(
          bottom: 180,
          left: 0,
          right: 0,
          child: Text(
            'Align QR code within the frame to scan',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
