import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:securepay/common/app_router.dart';
import 'package:securepay/common/navigation.dart';
import 'package:securepay/users/screens.dart';
import 'package:securepay/users/screens/user_list_screen.dart';

class UserRouter implements AppRouter {
  @override
  Map<NavDestination, StatefulShellBranch> get shellBranches => {
    const NavDestination(
      id: NavId.users,
      label: 'Users',
      icon: Icons.group,
      path: '/users',
    ): StatefulShellBranch(
      routes: [
        GoRoute(path: '/users', builder: (_, _) => const UserListScreen()),
      ],
    ),
  };

  @override
  List<RouteBase> get publicRoutes => [
    GoRoute(
      path: '/users/register',
      builder: (_, _) => const RegistrationScreen(),
    ),
    GoRoute(
      path: '/users/:id',
      builder: (context, state) {
        final idParam = state.pathParameters['id'];
        final userId = int.tryParse(idParam ?? '') ?? 0;
        return UserDetailsScreen(userId: userId);
      },
    ),
  ];
}
