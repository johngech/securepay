import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:securepay/common/app_router.dart';
import 'package:securepay/common/navigation.dart';
import 'package:securepay/users/screens.dart';

class UserRouter implements AppRouter {
  @override
  Map<NavDestination, StatefulShellBranch> get shellBranches => {
    const NavDestination(
      id: NavId.profile,
      label: 'Me',
      icon: Icons.person,
      path: '/profile',
    ): StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/profile',
          builder: (_, __) => const ProfileUpdateScreen(),
        ),
      ],
    ),
  };

  @override
  List<RouteBase> get publicRoutes => [
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/register', builder: (_, __) => const RegistrationScreen()),
  ];
}
