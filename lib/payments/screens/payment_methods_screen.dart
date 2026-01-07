import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:securepay/payments/widgets.dart';
import 'package:securepay/security/widgets.dart';

class PaymentMethodsScreen extends ConsumerWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: const SettingsAppBar(title: 'Payment Methods'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SettingsSectionTitle(title: 'Connected Accounts'),
            StripeAccountCard(),
            SizedBox(height: 20),
            PayPalAccountCard(),
            SizedBox(height: 20),
            RazorparyAccountCard(),
            SizedBox(height: 32),
            SettingsSectionTitle(title: 'Add Payment Method'),
            AddMethodActionList(),
            SizedBox(height: 24),
            SecurityDisclaimerNote(),
          ],
        ),
      ),
    );
  }
}
