import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:securepay/common/themes/app_colors.dart';
import 'package:securepay/payments/providers.dart';
import 'package:securepay/payments/widgets.dart';

class TransactionHistoryScreen extends ConsumerWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HistoryAppBar(),
      body: RefreshIndicator(
        onRefresh: () => ref.watch(transactionsListProvider.future),
        child: Column(
          children: [
            const HistorySearchAndFilter(),
            Expanded(
              child: transactionsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('Error: $err')),
                data: (transactions) => SlidableAutoCloseBehavior(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    children: [
                      const SizedBox(height: 24),
                      SummaryCardsRow(transactions: transactions),
                      const SizedBox(height: 24),
                      TransactionList(transactions: transactions),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HistoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'Transaction History',
        style: TextStyle(
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.download_rounded,
            color: AppColors.primaryBlue,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HistorySearchAndFilter extends StatelessWidget {
  const HistorySearchAndFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search transactions...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: const Color(0xFFF5F7FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            spacing: 8,
            children: const [
              FilterChip(label: 'All', isActive: true),
              FilterChip(label: 'Sent', isActive: false),
              FilterChip(label: 'Received', isActive: false),
            ],
          ),
        ],
      ),
    );
  }
}

class SummaryCardsRow extends StatelessWidget {
  final List<Transaction> transactions;
  const SummaryCardsRow({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    // Logic to calculate totals from the actual data
    final totalSent = transactions
        .where((t) => t.type == 'TRANSFER' || t.type == 'PAYMENT')
        .fold(0.0, (sum, item) => sum + item.amount);

    // For this example, assuming 'SUCCESS' counts as received if type is different
    // Adjust this logic based on your specific business rules
    final totalReceived = transactions
        .where(
          (t) =>
              (t.status == 'SUCCESS' || t.status == "DEPOSIT") &&
              t.type != 'PAYMENT',
        )
        .fold(0.0, (sum, item) => sum + item.amount);

    return Row(
      children: [
        Expanded(
          child: SummaryCard(
            label: 'Total Sent',
            amount: totalSent.toStringAsFixed(2),
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SummaryCard(
            label: 'Total Received',
            amount: totalReceived.toStringAsFixed(2),
            color: AppColors.actionGreen,
          ),
        ),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String label;
  final String amount;
  final Color color;

  const SummaryCard({
    super.key,
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            '\$$amount',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: Text("No transactions found"),
      );
    }
    return ListView.separated(
      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      separatorBuilder: (context, index) => const Divider(height: 32),
      itemBuilder: (context, index) {
        return TransactionItem(tx: transactions[index]);
      },
    );
  }
}

class FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  const FilterChip({super.key, required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryBlue : AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey.shade700,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
