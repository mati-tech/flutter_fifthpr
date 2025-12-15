// lib/domain/usecases/cart/update_quantity_usecase.dart
import '../../../core/models/cart_item.dart';
import '../../interfaces/repositories/cart_repository.dart';
// import '../../entities/cart_item.dart';

class UpdateQuantityUseCase {
  final CartRepository repository;

  UpdateQuantityUseCase(this.repository);

  Future<CartItem> execute(String cartItemId, int quantity) async {
    if (cartItemId.isEmpty) {
      throw ArgumentError('Cart item ID cannot be empty');
    }
    if (quantity <= 0) {
      throw ArgumentError('Quantity must be greater than 0');
    }

    return await repository.updateQuantity(cartItemId, quantity);
  }
}