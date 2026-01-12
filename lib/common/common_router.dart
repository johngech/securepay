import 'package:go_router/go_router.dart';
import 'package:securepay/common/navigation.dart';
import 'package:securepay/common/screens.dart';
import 'package:securepay/common/app_router.dart';

class CommonRouter implements AppRouter {
  @override
  List<RouteBase> get publicRoutes => [
    GoRoute(path: "/", builder: (context, state) => const SplashScreen()),
  ];

  @override
  Map<NavDestination, StatefulShellBranch> get shellBranches => {};
}
