import 'package:go_router/go_router.dart';
import 'package:securepay/security/security_center_screen.dart';
import 'package:securepay/security/security_settings_screen.dart';

class SecurityRouter {
  static const String center = '/security';
  static const String settings = 'settings'; // Sub-route

  static final List<RouteBase> routes = [
    GoRoute(
      path: center,
      builder: (context, state) => const SecurityCenterScreen(),
      routes: [
        GoRoute(
          path: settings,
          builder: (context, state) => const SecuritySettingsScreen(),
        ),
      ],
    ),
  ];
}