// // lib/domain/usecases/cart/remove_from_cart_usecase.dart
// import '../../interfaces/repositories/cart_repository.dart';
//
// class RemoveFromCartUseCase {
//   final CartRepository repository;
//
//   RemoveFromCartUseCase(this.repository);
//
//   Future<void> execute(String cartItemId) async {
//     if (cartItemId.isEmpty) {
//       throw ArgumentError('Cart item ID cannot be empty');
//     }
//
//     await repository.removeFromCart(cartItemId);
//   }
// }