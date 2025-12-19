// // lib/domain/interfaces/repositories/order_repository.dart
// import '../../../core/models/cart_item.dart';
// import '../../../core/models/order.dart';
// // import '../entities/order.dart';
//
// abstract class OrderRepository {
//   // Create order from cart
//   Future<Order> createOrder({
//     required List<CartItem> items,
//     required String shippingAddress,
//   });
//
//   // Get all orders
//   Future<List<Order>> getOrders();
//
//   // Get order by ID
//   Future<Order> getOrderById(String id);
//
//   // Cancel order
//   Future<void> cancelOrder(String orderId);
//
//   // Track order
//   Future<String?> trackOrder(String orderId);
// }