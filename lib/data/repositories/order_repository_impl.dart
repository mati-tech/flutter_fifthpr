// lib/data/repositories/order_repository_impl.dart
import '../../core/models/cart_item.dart';
import '../../core/models/order.dart';
import '../../domain/interfaces/repositories/order_repository.dart';
// import '../../domain/entities/order.dart';
// import '../../domain/entities/cart_item.dart';
import '../datasources/api/order_api_datasource.dart';
// import '../datasources/order_api_datasource.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApiDataSource dataSource;

  OrderRepositoryImpl(this.dataSource);

  @override
  Future<Order> createOrder({
    required List<CartItem> items,
    required String shippingAddress,
  }) async {
    // Convert CartItems to DTO format
    final itemsData = items.map((cartItem) {
      return {
        'product_id': cartItem.product.id,
        'name': cartItem.product.name,
        'price': cartItem.product.price,
        'quantity': cartItem.quantity,
        'image_url': cartItem.product.imageUrl,
      };
    }).toList();

    final response = await dataSource.createOrder(
      items: itemsData,
      shippingAddress: shippingAddress,
    );

    // Convert back to CartItems (simplified - in real app, use mappers)
    final orderItems = items; // Reuse the same items for simplicity

    return Order(
      id: response['id']?.toString() ?? '',
      items: orderItems,
      totalAmount: (response['total_amount'] ?? 0.0).toDouble(),
      orderDate: DateTime.parse(response['order_date']?.toString() ?? ''),
      status: _parseStatus(response['status']?.toString() ?? 'pending'),
      shippingAddress: response['shipping_address']?.toString() ?? '',
      trackingNumber: response['tracking_number']?.toString(),
    );
  }

  @override
  Future<List<Order>> getOrders() async {
    final ordersData = await dataSource.getOrders();

    return ordersData.map((orderData) {
      // Simplified - in real app, convert items properly
      return Order(
        id: orderData['id']?.toString() ?? '',
        items: [], // Empty for now - populate if needed
        totalAmount: (orderData['total_amount'] ?? 0.0).toDouble(),
        orderDate: DateTime.parse(orderData['order_date']?.toString() ?? ''),
        status: _parseStatus(orderData['status']?.toString() ?? 'pending'),
        shippingAddress: orderData['shipping_address']?.toString() ?? '',
        trackingNumber: orderData['tracking_number']?.toString(),
      );
    }).toList();
  }

  @override
  Future<Order> getOrderById(String id) async {
    final orderData = await dataSource.getOrderById(id);

    return Order(
      id: orderData['id']?.toString() ?? '',
      items: [], // Empty for now
      totalAmount: (orderData['total_amount'] ?? 0.0).toDouble(),
      orderDate: DateTime.parse(orderData['order_date']?.toString() ?? ''),
      status: _parseStatus(orderData['status']?.toString() ?? 'pending'),
      shippingAddress: orderData['shipping_address']?.toString() ?? '',
      trackingNumber: orderData['tracking_number']?.toString(),
    );
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await dataSource.cancelOrder(orderId);
  }

  @override
  Future<String?> trackOrder(String orderId) async {
    try {
      final order = await getOrderById(orderId);
      return order.trackingNumber;
    } catch (e) {
      return null;
    }
  }

  // Helper method to parse status string
  OrderStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }
}