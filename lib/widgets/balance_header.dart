import 'package:flutter/material.dart';

class BalanceHeader extends StatelessWidget {
  const BalanceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF1A237E),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.shield_outlined, color: Colors.green, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'SecurePay',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.logout, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Total Balance', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          const Row(
            children: [
              Text(
                '•••,•••.••',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 12),
              Icon(Icons.visibility_outlined, color: Colors.white54),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(Icons.verified_user, color: Colors.green, size: 16),
              SizedBox(width: 4),
              Text(
                'Protected',
                style: TextStyle(color: Colors.green, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
