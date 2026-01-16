import 'package:flutter/material.dart';
import 'package:securepay/settings/widgets/settings_card.dart';
import 'package:securepay/settings/widgets/settings_switch_tile.dart';

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
