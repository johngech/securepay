import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:securepay/common/app_router.dart';
import 'package:securepay/common/navigation.dart';
import 'package:securepay/common/themes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(List<AppRouter> features) {
  final shellBranches = <NavDestination, StatefulShellBranch>{};
  final publicRoutes = <RouteBase>[];

  for (final feature in features) {
    shellBranches.addAll(feature.shellBranches);
    publicRoutes.addAll(feature.publicRoutes);
  }

  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: [
      ...publicRoutes,

      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) {
          return Scaffold(
            backgroundColor: AppColors.bgGrey,
            body: shell,
            bottomNavigationBar: MainBottomNav(
              destinations: shellBranches.keys.toList(),
              shell: shell,
            ),
          );
        },
        branches: shellBranches.values.toList(),
      ),
    ],
  );
}
