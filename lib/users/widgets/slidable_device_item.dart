import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableDeviceItem extends StatelessWidget {
  final String deviceName;
  final String location;

  const SlidableDeviceItem({super.key, required this.deviceName, required this.location});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: const Color(0xFFD32F2F),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Logout',
            borderRadius: BorderRadius.circular(16),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: const Icon(Icons.smartphone, color: Color(0xFF1A237E)),
          title: Text(deviceName, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(location),
        ),
      ),
    );
  }
}