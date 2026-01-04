class PaymentState {
  final String recipientId;
  final String verifiedName;
  final bool isValidating;
  bool get isVerified => verifiedName.isNotEmpty;
  final String? errorMessage;

  PaymentState({
    this.recipientId = '',
    this.verifiedName = '',
    this.isValidating = false,
    this.errorMessage,
  });

  PaymentState copyWith({
    String? recipientId,
    String? verifiedName,
    bool? isValidating,
    String? errorMessage,
  }) {
    return PaymentState(
      recipientId: recipientId ?? this.recipientId,
      verifiedName: verifiedName ?? this.verifiedName,
      isValidating: isValidating ?? this.isValidating,
      errorMessage: errorMessage,
    );
  }
}
