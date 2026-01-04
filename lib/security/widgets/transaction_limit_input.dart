import 'package:flutter/material.dart';

class TransactionLimitInput extends StatelessWidget {
  const TransactionLimitInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Maximum amount for quick payments without additional authentication',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                prefixText: '\$ ',
                border: InputBorder.none,
                suffixIcon: Icon(Icons.unfold_more, color: Colors.grey),
              ),
              controller: null, // Assign controller in stateful implementation
            ),
          ),
        ],
      ),
    );
  }
}
