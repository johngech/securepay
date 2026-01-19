import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:securepay/common/themes.dart';
import 'package:securepay/payments/providers.dart';
import 'package:securepay/payments/widgets.dart';

class TransactionDashboardScreen extends ConsumerWidget {
  const TransactionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsListProvider);

    return Scaffold(
      backgroundColor: AppColors.bgGrey, // Soft background for contrast
      body: Column(
        children: [
          const BalanceHeader(), // The modular blue section
          Expanded(
            child: SlidableAutoCloseBehavior(
              child: RefreshIndicator(
                onRefresh: () => ref.watch(transactionsListProvider.future),
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
                              onPressed: () =>
                                  context.push("/transaction-history"),
                              child: const Text('View All'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Dynamic transactions list
                    transactionsAsync.when(
                      loading: () => const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (err, stack) => SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text('Failed to load transactions: $err'),
                        ),
                      ),
                      data: (transactions) {
                        if (transactions.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: Center(child: Text("No recent activity")),
                            ),
                          );
                        }
                        // We only show the latest 5 on the dashboard
                        final recentTxs = transactions.take(5).toList();

                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              return TransactionItem(tx: transactions[index]);
                            }, childCount: recentTxs.length),
                          ),
                        );
                      },
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 40)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
