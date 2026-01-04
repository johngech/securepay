import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:securepay/payments/entities.dart';

class PaymentNotifier extends Notifier<PaymentState> {
  Timer? _debounceTimer;

  @override
  PaymentState build() {
    // Clean up timer when the provider is disposed
    ref.onDispose(() => _debounceTimer?.cancel());
    return PaymentState();
  }

  void onRecipientChanged(String id) {
    _debounceTimer?.cancel();

    // Reset state immediately if input is too short
    if (id.length < 10) {
      state = PaymentState(recipientId: id);
      return;
    }

    // Debounce for 500ms to save server resources
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      lookupRecipient(id);
    });
  }

  Future<void> lookupRecipient(String id) async {
    state = state.copyWith(isValidating: true, errorMessage: null);

    try {
      // Professional Mock API lookup
      await Future.delayed(const Duration(milliseconds: 800));

      if (id == "0911223344") {
        state = state.copyWith(
          verifiedName: "Yohannes T.",
          isValidating: false,
        );
      } else {
        state = state.copyWith(
          verifiedName: '',
          isValidating: false,
          errorMessage: 'User not found',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isValidating: false,
        errorMessage: 'Connection failed',
      );
    }
  }
}

// Correct Provider Definition
final paymentProvider =
    NotifierProvider.autoDispose<PaymentNotifier, PaymentState>(
      PaymentNotifier.new,
    );
