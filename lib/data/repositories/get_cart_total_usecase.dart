// lib/domain/usecases/cart/get_cart_total_usecase.dart
import '../../domain/interfaces/repositories/cart_repository.dart';
// import '../../interfaces/repositories/cart_repository.dart';

class GetCartTotalUseCase {
  final CartRepository repository;

  GetCartTotalUseCase(this.repository);

  Future<double> execute() async {
    return await repository.getCartTotal();
  }
}