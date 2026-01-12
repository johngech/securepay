import 'package:flutter/material.dart';
import 'package:securepay/security/widgets.dart';

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
