// lib/domain/usecases/orders/create_order_usecase.dart
import '../../../core/models/cart_item.dart';
import '../../../core/models/order.dart';
import '../../interfaces/repositories/order_repository.dart';
// import '../../entities/order.dart';
// import '../../entities/cart_item.dart';

class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Order> execute({
    required List<CartItem> items,
    required String shippingAddress,
  }) async {
    if (items.isEmpty) {
      throw ArgumentError('Cannot create order with empty cart');
    }
    if (shippingAddress.isEmpty) {
      throw ArgumentError('Shipping address is required');
    }

    return await repository.createOrder(
      items: items,
      shippingAddress: shippingAddress,
    );
  }
}