import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:securepay/common/http_service.dart';
import 'package:securepay/common/services/dio_factory.dart';
import 'package:securepay/common/services/generic_http_service.dart';

class Transaction {
  final int? id;
  final String name;
  final String description;
  final double price;
  final int stockQuantity;
  final DateTime? createdAt;

  Transaction({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    this.createdAt,
  });

  // Factory to create a Product from Dio's Map
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as int?,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      stockQuantity: json['stockQuantity'] as int,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  // Convert Product to Map for POST/PUT requests
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stockQuantity': stockQuantity,
    };
  }
}

final transactionService = Provider<GenericHttpService<Transaction>>((ref) {
  final dio = ref.watch(dioProvider);
  return createHttpService<Transaction>(
    dio: dio,
    endpoint: "/transactions",
    fromJson: (json) => Transaction.fromJson(json),
  );
});
