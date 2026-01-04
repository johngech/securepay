import 'package:flutter/material.dart';

class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: const SettingsAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SettingsSectionTitle(title: 'Authentication'),
            AuthenticationSettingsGroup(),
            SizedBox(height: 24),
            SettingsSectionTitle(title: 'Payment Security'),
            PaymentSecurityGroup(),
            SizedBox(height: 24),
            SettingsSectionTitle(title: 'Privacy'),
            PrivacySettingsGroup(),
            SizedBox(height: 24),
            SettingsSectionTitle(title: 'Security Actions'),
            SecurityActionsGroup(),
            SizedBox(height: 24),
            SettingsSectionTitle(title: 'Session Timeout'),
            SessionTimeoutSelector(),
            SizedBox(height: 24),
            SettingsSectionTitle(title: 'Transaction Limit'),
            TransactionLimitInput(),
          ],
        ),
      ),
    );
  }
}

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      // The back button color matches the brand navy (0xFF1A237E)
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF1A237E)),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Security Settings',
        style: TextStyle(
          color: Color(0xFF1A237E),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      // Bottom border for a subtle separation from the body
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.withValues(alpha: 0.1),
          height: 1.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AuthenticationSettingsGroup extends StatelessWidget {
  const AuthenticationSettingsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      children: [
        SettingsSwitchTile(
          icon: Icons.fingerprint,
          title: 'Biometric Authentication',
          subtitle: 'Use Face ID or Touch ID to authenticate',
          initialValue: true,
        ),
        const Divider(height: 1, indent: 60),
        SettingsSwitchTile(
          icon: Icons.access_time,
          title: 'Auto Logout',
          subtitle: 'Automatically logout after 5 minutes of inactivity',
          initialValue: true,
        ),
      ],
    );
  }
}

class PrivacySettingsGroup extends StatelessWidget {
  const PrivacySettingsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      children: [
        SettingsSwitchTile(
          icon: Icons.visibility_off_outlined,
          title: 'Incognito Mode',
          subtitle: 'Hide amounts in app switcher and screenshots',
          initialValue: false,
        ),
        const Divider(height: 1, indent: 60),
        SettingsSwitchTile(
          icon: Icons.notifications_none_outlined,
          title: 'Security Notifications',
          subtitle: 'Get alerts for new logins and unusual activity',
          initialValue: true,
        ),
      ],
    );
  }
}

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

class SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const SettingsCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }
}

class SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool initialValue;

  const SettingsSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE8EAF6),
        child: Icon(icon, color: const Color(0xFF1A237E), size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: Switch(
        value: initialValue,
        onChanged: (val) {},
        activeThumbColor: const Color(0xFF00C853),
      ),
    );
  }
}

class SettingsSectionTitle extends StatelessWidget {
  final String title;
  const SettingsSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF546E7A), // Muted blue-grey for headers
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

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

class PaymentSecurityGroup extends StatelessWidget {
  const PaymentSecurityGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      children: [
        SettingsSwitchTile(
          icon: Icons.qr_code_2,
          title: 'QR Code Payments',
          subtitle: 'Allow payments via QR code scanning',
          initialValue: true,
        ),
        const Divider(height: 1, indent: 60),
        SettingsSwitchTile(
          icon: Icons.shutter_speed_outlined,
          title: 'Transaction Limits',
          subtitle: 'Require additional auth for amounts over \$500',
          initialValue: true,
        ),
      ],
    );
  }
}
