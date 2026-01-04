import 'package:go_router/go_router.dart';
import 'package:securepay/common/common_router.dart';
import 'package:securepay/payments/payment_router.dart';
import 'package:securepay/security/security_router.dart';

GoRouter getRouter() => GoRouter(
  initialLocation: '/splash',
  routes: [
    ...CommonRouter.routes,
    ...PaymentRouter.routes,
    ...SecurityRouter.routes,
  ],
);
