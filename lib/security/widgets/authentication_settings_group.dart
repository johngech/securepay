import 'package:flutter/material.dart';
import 'package:securepay/security/widgets.dart';

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
