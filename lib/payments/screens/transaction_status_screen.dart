import 'package:flutter/material.dart';
import 'package:securepay/payments/widgets.dart';

class TransactionStatusScreen extends StatefulWidget {
  final String amount;

  const TransactionStatusScreen({super.key, required this.amount});

  @override
  State<TransactionStatusScreen> createState() =>
      _TransactionStatusScreenState();
}

enum TransactionState { processing, success, failed }

class _TransactionStatusScreenState extends State<TransactionStatusScreen> {
  TransactionState _currentState = TransactionState.processing;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _processPayment();
  }

  Future<void> _processPayment() async {
    try {
      // Simulate API Call
      await Future.delayed(const Duration(seconds: 3));

      // Logic to determine success/failure (e.g., status code from server)
      bool isSuccessful = false;

      if (mounted) {
        setState(() {
          _currentState = isSuccessful
              ? TransactionState.success
              : TransactionState.failed;
          _errorMessage = "Insufficient balance in your linked account.";
        });
      }
    } catch (e) {
      setState(() {
        _currentState = TransactionState.failed;
        _errorMessage = "Connection lost. Please check your internet.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (_currentState) {
        TransactionState.processing => ProcessingPaymentView(),
        TransactionState.success => SuccessPaymentView(amount: widget.amount),
        TransactionState.failed => PaymentFailedView(
          amount: widget.amount,
          errorReason: _errorMessage,
        ),
      },
    );
  }
}
