import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecurityAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SecurityAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1A237E),
      elevation: 0,
      title: const Text(
        'Security Center',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () => context.push('/security/settings'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
