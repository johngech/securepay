import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const SettingsAppBar({super.key, this.title = 'Security Settings'});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      // The back button color matches the brand navy (0xFF1A237E)
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back, color: Color(0xFF1A237E)),
      //   onPressed: () => context.go("/transaction-dashboard"),
      // ),
      title: Text(
        title,
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
