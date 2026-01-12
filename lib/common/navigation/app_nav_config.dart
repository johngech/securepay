import 'package:flutter/material.dart';
import 'package:securepay/common/navigation.dart';

class AppNavConfig {
  static const List<NavDestination> destinations = [
    NavDestination(
      id: NavId.home,
      label: 'Home',
      icon: Icons.home_filled,
      path: '/transaction-dashboard',
    ),
    NavDestination(
      id: NavId.history,
      label: 'History',
      icon: Icons.history_rounded,
      path: '/transaction-history',
    ),
    NavDestination(
      id: NavId.security,
      label: 'Security',
      icon: Icons.shield_outlined,
      path: '/security',
    ),
    NavDestination(
      id: NavId.cards,
      label: 'Cards',
      icon: Icons.credit_card_rounded,
      path: '/payment-methods',
    ),
    NavDestination(
      id: NavId.profile,
      label: 'Me',
      icon: Icons.person,
      path: '/profile',
    ),
  ];
}
