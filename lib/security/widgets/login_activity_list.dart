import 'package:flutter/material.dart';
import 'package:securepay/security/widgets.dart';

class LoginActivityList extends StatelessWidget {
  const LoginActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: const [
          ActivityItemTile(
            device: 'iPhone 15 Pro',
            location: 'San Francisco, CA',
            time: 'Today at 10:30 AM',
            status: 'Success',
            isSuccess: true,
          ),
          Divider(height: 1, indent: 70),
          ActivityItemTile(
            device: 'iPad Air',
            location: 'San Francisco, CA',
            time: 'Yesterday at 8:15 PM',
            status: 'Success',
            isSuccess: true,
          ),
          Divider(height: 1, indent: 70),
          ActivityItemTile(
            device: 'Unknown Device',
            location: 'Los Angeles, CA',
            time: '2 days ago at 3:45 PM',
            status: 'Failed',
            isSuccess: false,
          ),
        ],
      ),
    );
  }
}
