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
