import 'package:flutter_riverpod/legacy.dart';
import 'package:securepay/payments/entities.dart';

final selectedPaymentProvider = StateProvider<PaymentType>(
  (ref) => PaymentType.stripe,
);
