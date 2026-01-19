import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:securepay/common/themes.dart';
import 'package:securepay/payments/providers.dart';

class TransactionItem extends ConsumerWidget {
  final Transaction tx;
  const TransactionItem({super.key, required this.tx});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Logic for styling based on transaction type and status
    final bool isTransfer = tx.type == 'TRANSFER';
    final Color statusColor = _getStatusColor(tx.status);

    final formattedDate = DateFormat("MMM y,d").format(tx.createdAt);
    final formattedTime = DateFormat.jm().format(tx.createdAt);
    final dateTime = "$formattedDate $formattedTime";
    return Slidable(
      key: ValueKey(tx.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => _handleDelete(context, ref),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: AppColors.bgGrey,
          child: Icon(
            isTransfer ? Icons.swap_horiz : Icons.arrow_upward,
            color: AppColors.primaryBlue,
            size: 18,
          ),
        ),
        title: Text(
          tx.description,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$dateTime • ${tx.provider}',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(
              'Code: ${tx.transactionCode}',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${tx.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              tx.status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'SUCCESS' || "COMPLETED":
        return Colors.green;
      case 'PENDING':
        return Colors.orange;
      case 'FAILED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> _handleDelete(BuildContext context, WidgetRef ref) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      // Use the generic service to delete from the server
      await ref.read(transactionServiceProvider).delete(tx.id);

      // Refresh the list provider to update the UI
      ref.invalidate(transactionsListProvider);

      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Transaction deleted')),
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Failed to delete: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
