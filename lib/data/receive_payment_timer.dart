import 'package:flutter_riverpod/flutter_riverpod.dart';

// A simple provider to manage the 5-minute expiry countdown
final receiveTimerProvider = StreamProvider.autoDispose<int>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (i) => 286 - i).take(287);
});
