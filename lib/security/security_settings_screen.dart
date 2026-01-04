import 'package:flutter/material.dart';
import 'package:securepay/security/widgets.dart';

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
