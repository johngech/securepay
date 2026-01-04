import 'package:flutter/material.dart';

class DeviceItemTile extends StatelessWidget {
  final String device;
  final String location;
  final String time;
  final String ip;
  final bool isCurrent;

  const DeviceItemTile({
    super.key,
    required this.device,
    required this.location,
    required this.time,
    this.isCurrent = false,
    required this.ip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isCurrent
                ? const Color(0xFFE8F5E9)
                : const Color(0xFFF5F7FA),
            child: Icon(
              Icons.phone_iphone,
              color: isCurrent ? const Color(0xFF00C853) : Colors.grey,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      device,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (isCurrent) ...[
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.circle,
                        size: 8,
                        color: Color(0xFF00C853),
                      ),
                    ],
                  ],
                ),
                Text(
                  'IP: $ip',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  '$location • $time',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          if (!isCurrent)
            const Text(
              'Remove',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
