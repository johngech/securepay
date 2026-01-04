import 'package:go_router/go_router.dart';
import 'package:securepay/common/screens.dart';

class CommonRouter {
  static final routes = <GoRoute>[
    GoRoute(path: "/splash", builder: (context, state) => const SplashScreen()),
  ];
}
