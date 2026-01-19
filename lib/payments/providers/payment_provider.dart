import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:securepay/common/http_service.dart';
import 'package:securepay/common/services/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:securepay/payments/providers.dart';

// The handshake model for the Create method response
class PaymentResponse {
  final int transactionId;
  final String provider;
  final String transactionCode;
  final String? sessionType;
  final String status;
  final String? externalRef;
  final DateTime? createdAt;
  final Map<String, dynamic> nextAction;

  PaymentResponse({
    required this.transactionId,
    required this.provider,
    this.sessionType,
    required this.status,
    this.createdAt,
    this.externalRef,
    required this.nextAction,
    required this.transactionCode,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      transactionId: json['id'] as int,
      provider: json['provider'] as String? ?? "UNKNOWN",
      transactionCode: json['transactionCode'] as String,
      sessionType: json['sessionType'] as String? ?? "INTERNAL",
      status: json['status'] as String,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      externalRef: json['externalRef'] as String?,
      nextAction: json['nextAction'] as Map<String, dynamic>? ?? {},
    );
  }
}

final paymentServiceProvider = Provider<GenericHttpService<PaymentResponse>>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return createHttpService<PaymentResponse>(
    dio: dio,
    endpoint: "/payments/top-up",
    fromJson: (json) => PaymentResponse.fromJson(json),
  );
});

class PaymentNotifier extends StateNotifier<AsyncValue<PaymentResponse?>> {
  final Ref ref;
  PaymentNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> processTopUp(double amount) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      // 1. Use the Generic Service to POST the intent
      // Passing { "amount": amount } as the map
      final response = await ref.read(paymentServiceProvider).create({
        'amount': amount,
      });

      // 2. Handle Stripe Side-effects if applicable
      if (response.provider == 'STRIPE' &&
          response.nextAction.containsKey('client_secret')) {
        final clientSecret = response.nextAction['client_secret'];

        // Initialize Stripe Sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'SecurePay',
          ),
        );

        // Present Stripe Sheet
        await Stripe.instance.presentPaymentSheet();
      }

      // 3. Success! Refresh the main transaction list automatically
      ref.invalidate(transactionsListProvider);

      return response;
    });
  }

  // --- NEW INTERNAL SEND METHOD ---
  Future<void> sendInternalPayment({
    required String contact,
    required double amount,
    required String description,
    required String pin,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final dio = ref.read(dioProvider);

      final bool isEmail = contact.contains('@');

      final Map<String, dynamic> requestBody = {
        "receiver": {
          "email": isEmail ? contact : "",
          "phone": isEmail ? "" : contact,
        },
        "amount": amount,
        "description": description,
        "pin": pin,
      };

      // POST to the internal send endpoint
      final response = await dio.post('/payments/send', data: requestBody);

      // Map the generic Transaction response back to PaymentResponse or Transaction
      final result = PaymentResponse.fromJson(response.data);

      ref.invalidate(transactionsListProvider);
      return result;
    });
  }

  void reset() => state = const AsyncValue.data(null);
}

final paymentNotifierProvider =
    StateNotifierProvider<PaymentNotifier, AsyncValue<PaymentResponse?>>((ref) {
      return PaymentNotifier(ref);
    });
