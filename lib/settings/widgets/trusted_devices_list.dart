import 'package:flutter/material.dart';
import 'package:securepay/settings/widgets/device_item_tile.dart';

class TrustedDevicesList extends StatelessWidget {
  const TrustedDevicesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: const [
          DeviceItemTile(
            device: 'iPhone 15 Pro',
            location: 'San Francisco, CA',
            ip: '192.168.1.1',
            time: 'Active now',
            isCurrent: true,
          ),
          Divider(height: 1, indent: 70),
          DeviceItemTile(
            device: 'MacBook Pro',
            location: 'San Francisco, CA',
            ip: '192.168.1.5',
            time: '2 hours ago',
            isCurrent: false,
          ),
        ],
      ),
    );
  }
}
