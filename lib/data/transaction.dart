import 'package:flutter_riverpod/flutter_riverpod.dart';

class Transaction {
  final String id;
  final String title;
  final String date;
  final double amount;
  final bool isCredit;

  Transaction({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.isCredit,
  });
}

final transactionProvider =
    NotifierProvider<TransactionNotifier, List<Transaction>>(() {
      return TransactionNotifier();
    });

class TransactionNotifier extends Notifier<List<Transaction>> {
  @override
  List<Transaction> build() => [
    Transaction(
      id: '1',
      title: 'Starbucks Coffee',
      date: '2 hours ago',
      amount: 5.99,
      isCredit: false,
    ),
    Transaction(
      id: '2',
      title: 'John Doe',
      date: 'Yesterday',
      amount: 150.00,
      isCredit: true,
    ),
    Transaction(
      id: '3',
      title: 'Amazon Purchase',
      date: '2 days ago',
      amount: 89.99,
      isCredit: false,
    ),
  ];

  void removeTransaction(String id) {
    state = [
      for (final tx in state)
        if (tx.id != id) tx,
    ];
  }
}
