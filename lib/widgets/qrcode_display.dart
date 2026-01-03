import 'package:flutter/material.dart';

class QRCodeDisplay extends StatelessWidget {
  final String data;
  const QRCodeDisplay({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A237E),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        spacing: 16,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            // In production, use qr_flutter package here
            child: Image.network(
              'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=$data',
              height: 200,
              width: 200,
            ),
          ),

          const Text(
            'SecurePay QR Code',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
