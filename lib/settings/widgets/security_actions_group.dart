import 'package:flutter/material.dart';
import 'package:securepay/settings/widgets/settings_card.dart';

class SecurityActionsGroup extends StatelessWidget {
  const SecurityActionsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      children: [
        _ActionTile(
          icon: Icons.lock_outline,
          title: 'Change PIN',
          onTap: () {},
        ),
        const Divider(height: 1, indent: 60),
        _ActionTile(
          icon: Icons.fingerprint,
          title: 'Reset Biometrics',
          onTap: () {},
        ),
        const Divider(height: 1, indent: 60),
        _ActionTile(
          icon: Icons.verified_user_outlined,
          title: 'Two-Factor Authentication',
          onTap: () {},
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: const Color(0xFF1A237E), size: 22),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      ),
      trailing: const Icon(Icons.arrow_forward, size: 18, color: Colors.grey),
    );
  }
}
