import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:securepay/payments/providers.dart';
import 'package:securepay/payments/widgets.dart';

class TransactionDashboardScreen extends ConsumerWidget {
  const TransactionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Accessing the state via Riverpod
    final transactions = ref.watch(transactionProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE), // Soft background for contrast
      body: Column(
        children: [
          const BalanceHeader(), // The modular blue section
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                // 1. Action Cards Section
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ActionButtonsRow(),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 32)),

                // 2. Section Header: "Recent Transactions"
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Transactions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.push("/transaction-history"),
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return TransactionItem(tx: transactions[index]);
                    }, childCount: transactions.length),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
