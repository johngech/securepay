import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:securepay/common/http_service.dart';
import 'package:securepay/common/services/dio_factory.dart';
import 'package:securepay/common/services/generic_http_service.dart';

class Transaction {
  final int id;
  final String transactionCode;
  final String provider;
  final double amount;
  final String type; // e.g., 'TRANSFER', 'PAYMENT'
  final String status; // e.g., 'PENDING', 'SUCCESS'
  final String description;
  final DateTime createdAt;

  Transaction({
    required this.id,
    required this.transactionCode,
    required this.provider,
    required this.amount,
    required this.type,
    required this.status,
    required this.description,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as int,
      transactionCode: json['transactionCode'] as String,
      provider: json['provider'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      status: json['status'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transactionCode': transactionCode,
      'provider': provider,
      'amount': amount,
      'type': type,
      'status': status,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

final transactionFormProvider = Provider.autoDispose((ref) {
  return fb.group({
    'provider': ['STRIPE', Validators.required], // e.g. STRIPE, PAYPAL, BANK
    'amount': [0.0, Validators.required, Validators.min(0.01)],
    'type': ['TRANSFER', Validators.required],
    'description': ['', Validators.required, Validators.maxLength(100)],
  });
});

final transactionServiceProvider = Provider<GenericHttpService<Transaction>>((
  ref,
) {
  final dio = ref.watch(dioProvider);

  return createHttpService<Transaction>(
    dio: dio,
    endpoint: "/transactions",
    fromJson: (json) => Transaction.fromJson(json),
  );
});

final transactionsListProvider = FutureProvider.autoDispose<List<Transaction>>((
  ref,
) {
  final service = ref.watch(transactionServiceProvider);
  return service.getAll();
});

final transactionDetailsProvider = FutureProvider.autoDispose
    .family<Transaction, int>((ref, txId) async {
      final service = ref.watch(transactionServiceProvider);
      return service.getById(txId);
    });

final transactionProcessingProvider = StateProvider<bool>((ref) => false);
