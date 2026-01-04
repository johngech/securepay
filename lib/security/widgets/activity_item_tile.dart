import 'package:flutter/material.dart';

class ActivityItemTile extends StatelessWidget {
  final String device;
  final String location;
  final String time;
  final String status;
  final bool isSuccess;

  const ActivityItemTile({
    super.key,
    required this.device,
    required this.location,
    required this.time,
    required this.status,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: isSuccess
            ? const Color(0xFFE8F5E9)
            : const Color(0xFFFFEBEE),
        child: Icon(
          isSuccess ? Icons.shield_outlined : Icons.warning_amber_rounded,
          color: isSuccess ? const Color(0xFF00C853) : const Color(0xFFD32F2F),
        ),
      ),
      title: Text(device, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(location, style: const TextStyle(fontSize: 12)),
          Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSuccess ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          status,
          style: TextStyle(
            color: isSuccess
                ? const Color(0xFF00C853)
                : const Color(0xFFD32F2F),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
