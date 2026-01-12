import 'package:go_router/go_router.dart';
import 'package:securepay/common/navigation.dart';

abstract interface class AppRouter {
  List<RouteBase> get publicRoutes;

  Map<NavDestination, StatefulShellBranch> get shellBranches;
}
