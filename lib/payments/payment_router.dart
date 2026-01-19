import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:securepay/common/app_router.dart';
import 'package:securepay/common/navigation.dart';
import 'package:securepay/payments/screens.dart';

class PaymentRouter implements AppRouter {
  @override
  Map<NavDestination, StatefulShellBranch> get shellBranches => {
    const NavDestination(
      id: NavId.home,
      label: 'Home',
      icon: Icons.home_filled,
      path: '/transaction-dashboard',
    ): StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/transaction-dashboard',
          builder: (_, _) => const TransactionDashboardScreen(),
        ),
      ],
    ),

    const NavDestination(
      id: NavId.history,
      label: 'History',
      icon: Icons.history_rounded,
      path: '/transaction-history',
    ): StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/transaction-history',
          builder: (_, _) => const TransactionHistoryScreen(),
        ),
      ],
    ),

    const NavDestination(
      id: NavId.cards,
      label: 'Cards',
      icon: Icons.credit_card_rounded,
      path: '/payment-methods',
    ): StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/payment-methods',
          builder: (_, _) => const PaymentMethodsScreen(),
        ),
      ],
    ),
  };

  @override
  List<RouteBase> get publicRoutes => [
    GoRoute(
      path: '/send-payment',
      builder: (_, _) => const SendPaymentScreen(),
    ),
    GoRoute(
      path: '/confirm-payment',
      builder: (_, _) => const ConfirmPaymentScreen(
        amount: "100",
        recipient: "Yohannes",
        paymentMethod: "Stripe",
      ),
    ),
    GoRoute(
      path: '/receive-payment',
      builder: (_, _) => const ReceivePaymentScreen(),
    ),
    GoRoute(
      path: '/pin-entry',
      builder: (context, state) {
        final amount = state.extra as String? ?? '0.0';
        return PinEntryScreen(amount: amount);
      },
    ),
    GoRoute(
      path: "/transaction-status",
      builder: (context, state) {
        final amount = state.extra as String? ?? '0.00';
        return TransactionStatusScreen(amount: amount);
      },
    ),
    GoRoute(path: "/qr-scanner", builder: (_, _) => const ScanScreen()),
  ];
}
