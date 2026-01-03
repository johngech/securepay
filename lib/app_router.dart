import 'package:go_router/go_router.dart';
import 'package:securepay/securepay_screens.dart';

GoRouter getRouter() => GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: "/", builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: "/pin-entry",
      builder: (context, state) => const PinEntryScreen(),
    ),
    GoRoute(
      path: "/transaction-dashboard",
      builder: (context, state) => const TransactionDashboardScreen(),
    ),
    GoRoute(
      path: "/send-payment",
      builder: (context, state) => const SendPaymentScreen(),
    ),
    GoRoute(
      path: "/receive-payment",
      builder: (context, state) => const ReceivePaymentScreen(),
    ),
    GoRoute(
      path: "/qr-scanner",
      builder: (context, state) => const ScanScreen(),
    ),
  ],
);
