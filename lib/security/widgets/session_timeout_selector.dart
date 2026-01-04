import 'package:flutter/material.dart';

class SessionTimeoutSelector extends StatelessWidget {
  const SessionTimeoutSelector({super.key});

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
            'Choose how long before automatically logging out',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildTimeOption('1 min', false),
              const SizedBox(width: 8),
              _buildTimeOption('5 min', true),
              const SizedBox(width: 8),
              _buildTimeOption('15 min', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeOption(String label, bool isSelected) {
    return Expanded(
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A237E) : const Color(0xFFF5F7FA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
