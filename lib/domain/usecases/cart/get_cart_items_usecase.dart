// // lib/domain/usecases/cart/get_cart_items_usecase.dart
// import '../../../core/models/cart_product.dart';
// import '../../interfaces/repositories/cart_repository.dart';
// // import '../../entities/cart_product.dart';
//

import '../../../core/models/cart.dart';
import '../../../data/repositories/product_repository_impl.dart';

class GetCartByUserUseCase {
  final ProductRepositoryImpl repository;

  GetCartByUserUseCase(this.repository);

  Future<List<Cart>> execute(int userId) async {
    return await repository.getCartByUserId(userId);
  }
}