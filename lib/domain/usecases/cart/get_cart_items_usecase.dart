// lib/domain/usecases/cart/get_cart_items_usecase.dart
import '../../../core/models/cart_item.dart';
import '../../interfaces/repositories/cart_repository.dart';
// import '../../entities/cart_item.dart';

class GetCartItemsUseCase {
  final CartRepository repository;

  GetCartItemsUseCase(this.repository);

  Future<List<CartItem>> execute() async {
    return await repository.getCartItems();
  }
}