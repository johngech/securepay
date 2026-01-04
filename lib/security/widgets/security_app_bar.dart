import 'package:flutter/material.dart';

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
