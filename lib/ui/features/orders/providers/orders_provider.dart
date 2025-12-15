import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/models/cart_item.dart';
import '../../../../core/models/order.dart';



part 'orders_provider.g.dart';

@riverpod
class OrdersNotifier extends _$OrdersNotifier {
  @override
  OrdersState build() {
    return OrdersState(orders: []);
  }

  void addOrder(List<CartItem> items, double totalAmount, String shippingAddress) {
    final currentOrders = List<Order>.from(state.orders);
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List.from(items),
      totalAmount: totalAmount,
      orderDate: DateTime.now(),
      status: OrderStatus.pending,
      shippingAddress: shippingAddress,
    );

    currentOrders.insert(0, order);
    state = OrdersState(orders: currentOrders);
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final currentOrders = List<Order>.from(state.orders);
    final index = currentOrders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      // In a real app, you'd create a copy with updated status
      // For now, we'll keep the same order structure
      state = OrdersState(orders: currentOrders);
    }
  }

  Order? getOrder(String orderId) {
    try {
      return state.orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }

  List<Order> getOrdersByStatus(OrderStatus status) {
    return state.orders.where((order) => order.status == status).toList();
  }
}

class OrdersState {
  final List<Order> orders;

  OrdersState({required this.orders});

  int get ordersCount => orders.length;
}

