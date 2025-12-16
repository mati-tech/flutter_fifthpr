// lib/domain/entities/order.dart
import 'cart_item.dart';

enum OrderStatus {
  pending,
  confirmed,
  shipped,
  delivered,
  cancelled,
}

class Order {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime orderDate;
  final OrderStatus status;
  final String shippingAddress;
  final String? trackingNumber;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
    required this.shippingAddress,
    this.trackingNumber,
  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}