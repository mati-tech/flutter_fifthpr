// lib/domain/usecases/cart/add_to_cart_usecase.dart
import '../../../core/models/cart_item.dart';
import '../../interfaces/repositories/cart_repository.dart';
// import '../../entities/cart_item.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<CartItem> execute(String productId, {int quantity = 1}) async {
    if (productId.isEmpty) {
      throw ArgumentError('Product ID cannot be empty');
    }
    if (quantity <= 0) {
      throw ArgumentError('Quantity must be greater than 0');
    }

    return await repository.addToCart(productId, quantity: quantity);
  }
}