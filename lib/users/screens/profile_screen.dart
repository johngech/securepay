import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:securepay/security/widgets.dart';
import 'package:securepay/users/widgets.dart';

class ProfileUpdateScreen extends ConsumerStatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  ConsumerState<ProfileUpdateScreen> createState() =>
      _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends ConsumerState<ProfileUpdateScreen> {
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: const SettingsAppBar(
        title: "User profiles",
      ), // Reused from previous step
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const ProfileAvatarSection(),
            const SizedBox(height: 32),
            const SectionTitle(title: "Personal Information"),
            const AuthenticationSettingsGroup(), // Reusing card styles
            const SizedBox(height: 24),
            const SectionTitle(title: "Linked Devices"),
            const SlidableDeviceItem(
              deviceName: "iPhone 15 Pro",
              location: "London, UK",
            ),
            const SizedBox(height: 40),
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}
