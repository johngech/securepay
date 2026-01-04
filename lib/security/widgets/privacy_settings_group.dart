import 'package:flutter/material.dart';
import 'package:securepay/security/widgets.dart';

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
