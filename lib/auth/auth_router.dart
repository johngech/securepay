import 'package:go_router/go_router.dart';
import 'package:securepay/auth/login_screen.dart';
import 'package:securepay/common/app_router.dart';
import 'package:securepay/common/navigation.dart';

class AuthRouter implements AppRouter{

  @override
  Map<NavDestination, StatefulShellBranch> get shellBranches =>{};
  
  @override
  List<RouteBase> get publicRoutes =>[
    GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
  ];
}