import 'dart:ui';

// import '../../ui/features/cart/models/cart_item.dart';
import '../../ui/shared/app_theme.dart';
import 'cart_item.dart';

// import '../../features/cart/models/cart_item.dart';
// import '../../shared/app_theme.dart';


enum OrderStatus {
  pending,
  confirmed,
  shipped,
  delivered,
  cancelled,
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return Color(0xFFFF9800); // Orange
      case OrderStatus.confirmed:
        return Color(0xFF2196F3); // Blue
      case OrderStatus.shipped:
        return Color(0xFF9C27B0); // Purple
      case OrderStatus.delivered:
        return AppTheme.successColor;
      case OrderStatus.cancelled:
        return AppTheme.errorColor;
    }
  }
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