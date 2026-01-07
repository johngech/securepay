import 'package:go_router/go_router.dart';
import 'package:securepay/payments/screens.dart';

class PaymentRouter {
  static final List<RouteBase> routes = <RouteBase>[
    GoRoute(
      path: "/pin-entry",
      builder: (context, state) => const PinEntryScreen(),
    ),
    GoRoute(
      path: "/transaction-dashboard",
      builder: (context, state) => const TransactionDashboardScreen(),
    ),
    GoRoute(
      path: "/transaction-history",
      builder: (context, state) => const TransactionHistoryScreen(),
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
      path: "/payment-methods",
      builder: (context, state) => const PaymentMethodsScreen(),
    ),
    GoRoute(
      path: "/qr-scanner",
      builder: (context, state) => const ScanScreen(),
    ),
    GoRoute(
      path: "/confirm-payment",
      builder: (context, state) => const ConfirmPaymentScreen(
        amount: '100.00',
        recipient: 'John Doe',
        paymentMethod: 'Visa **** 1234',
      ),
    ),
    GoRoute(
      path: "/transaction-status",
      builder: (context, state) =>
          const TransactionStatusScreen(amount: '100.00'),
    ),
  ];
}
