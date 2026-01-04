import 'package:flutter/material.dart';

class SecurityCenterScreen extends StatelessWidget {
  const SecurityCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: const SecurityAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SecurityStatusHeader(),
                  SizedBox(height: 32),
                  SectionTitle(title: 'Active Authentication'),
                  AuthenticationList(),
                  SizedBox(height: 32),
                  SectionTitle(title: 'Trusted Devices'),
                  TrustedDevicesList(),
                  SizedBox(height: 32),
                  SectionTitle(title: 'Recent Login Activity'),
                  LoginActivityList(),
                ],
              ),
            ),
          ),
          const PanicLockButtonArea(),
        ],
      ),
    );
  }
}

class SecurityAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SecurityAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1A237E),
      elevation: 0,
      leading: const BackButton(color: Colors.white),
      title: const Text(
        'Security Center',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SecurityStatusHeader extends StatelessWidget {
  const SecurityStatusHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A237E),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.shield_outlined,
              color: Color(0xFF00C853),
              size: 32,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Account Protected',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'All security features active',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF455A64),
        ),
      ),
    );
  }
}

class AuthenticationList extends StatelessWidget {
  const AuthenticationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: const [
          AuthTile(
            icon: Icons.face_retouching_natural,
            label: 'Biometric (Face ID)',
          ),
          Divider(height: 1),
          AuthTile(icon: Icons.dialpad, label: '6-Digit PIN'),
          Divider(height: 1),
          AuthTile(icon: Icons.qr_code_scanner, label: 'QR Code Payments'),
        ],
      ),
    );
  }
}

class AuthTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const AuthTile({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1A237E)),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text(
          'Active',
          style: TextStyle(
            color: Color(0xFF00C853),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

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

class PanicLockButtonArea extends StatelessWidget {
  const PanicLockButtonArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.lock_outline),
              label: const Text('Panic Lock - Lock Account Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'This will immediately lock your account and sign you out from all devices',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

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
