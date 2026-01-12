import 'package:flutter/widgets.dart';
import 'package:securepay/common/navigation.dart';

class NavDestination {
  final NavId id;
  final String label;
  final IconData icon;
  final String path;

  const NavDestination({
    required this.id,
    required this.label,
    required this.icon,
    required this.path,
  });
}
