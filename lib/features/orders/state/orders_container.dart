import 'package:flutter/material.dart';
import '../models/order.dart';
import '../../cart/models/cart_item.dart';

class OrdersContainer extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;
  int get ordersCount => _orders.length;

  void addOrder(List<CartItem> items, double totalAmount, String shippingAddress) {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List.from(items),
      totalAmount: totalAmount,
      orderDate: DateTime.now(),
      status: OrderStatus.pending,
      shippingAddress: shippingAddress,
    );

    _orders.insert(0, order);
    notifyListeners();
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      // In a real app, you'd create a copy with updated status
      // _orders[index] = _orders[index].copyWith(status: newStatus);
      notifyListeners();
    }
  }

  Order? getOrder(String orderId) {
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }

  List<Order> getOrdersByStatus(OrderStatus status) {
    return _orders.where((order) => order.status == status).toList();
  }
}