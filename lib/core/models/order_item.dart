// lib/domain/entities/order_item.dart
import 'product.dart'; // We need Product entity

class OrderItem {
  final String id;
  final Product product;
  final int quantity;
  final double unitPrice; // Price at time of order (snapshot)

  const OrderItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.unitPrice,
  });

  // Calculate total for this line item
  double get totalPrice => unitPrice * quantity;

  OrderItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    double? unitPrice,
  }) {
    return OrderItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderItem &&
        other.id == id &&
        other.product == product &&
        other.quantity == quantity &&
        other.unitPrice == unitPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    product.hashCode ^
    quantity.hashCode ^
    unitPrice.hashCode;
  }
}