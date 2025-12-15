/// Domain entity representing a payment method
/// Pure Dart class - no Flutter dependencies
enum PaymentType {
  creditCard,
  debitCard,
  paypal,
  applePay,
  googlePay,
  bankTransfer,
}

class PaymentMethod {
  final String id;
  final PaymentType type;
  final String? cardNumber; // Last 4 digits for display
  final String? cardHolderName;
  final String? expiryDate; // MM/YY format
  final bool isDefault;

  PaymentMethod({
    required this.id,
    required this.type,
    this.cardNumber,
    this.cardHolderName,
    this.expiryDate,
    this.isDefault = false,
  });

  String get displayName {
    switch (type) {
      case PaymentType.creditCard:
      case PaymentType.debitCard:
        if (cardNumber != null) {
          return '**** $cardNumber';
        }
        return 'Card';
      case PaymentType.paypal:
        return 'PayPal';
      case PaymentType.applePay:
        return 'Apple Pay';
      case PaymentType.googlePay:
        return 'Google Pay';
      case PaymentType.bankTransfer:
        return 'Bank Transfer';
    }
  }

  PaymentMethod copyWith({
    String? id,
    PaymentType? type,
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    bool? isDefault,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      type: type ?? this.type,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethod &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'PaymentMethod(id: $id, type: $type)';
}

