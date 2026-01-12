import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:securepay/common/app_router.dart';
import 'package:securepay/common/navigation.dart';
import 'package:securepay/security/screens.dart';

class SecurityRouter implements AppRouter {
  @override
  Map<NavDestination, StatefulShellBranch> get shellBranches => {
    NavDestination(
      id: NavId.security,
      label: 'Security',
      icon: Icons.shield_outlined,
      path: '/security',
    ): StatefulShellBranch(
      routes: [
        GoRoute(
          path: "/security",
          builder: (context, state) => const SecurityCenterScreen(),
          routes: [
            GoRoute(
              path: "settings",
              builder: (context, state) => const SecuritySettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  };

  @override
  List<RouteBase> get publicRoutes => [];
}
