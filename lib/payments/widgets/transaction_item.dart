import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:securepay/payments/providers/transaction_provider.dart';
import 'package:securepay/payments/entities/transaction.dart';

class TransactionItem extends ConsumerWidget {
  final Transaction tx;
  const TransactionItem({super.key, required this.tx});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      key: ValueKey(tx.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) =>
                ref.read(transactionProvider.notifier).removeTransaction(tx.id),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (_) {},
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: tx.isCredit
              ? Colors.green.withValues(alpha: 0.1)
              : Colors.blue.withValues(alpha: 0.1),
          child: Icon(
            tx.isCredit ? Icons.arrow_downward : Icons.arrow_upward,
            color: tx.isCredit ? Colors.green : Colors.blue,
            size: 16,
          ),
        ),
        title: Text(
          tx.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(tx.date, style: const TextStyle(fontSize: 12)),
        trailing: Text(
          '${tx.isCredit ? '+' : ''}\$${tx.amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: tx.isCredit ? Colors.teal : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
