// lib/domain/usecases/products/get_product_by_id_usecase.dart
import '../../../core/models/product.dart';
import '../../interfaces/repositories/product_repository.dart';
// import '../../entities/product.dart';
//
class GetProductByIdUseCase {
  final ProductRepository repository;

  GetProductByIdUseCase(this.repository);

  Future<Product> execute(String id) async {
    // Business validation: Check ID is not empty
    if (id.isEmpty) {
      throw ArgumentError('Product ID cannot be empty');
    }

    return await repository.getProductById(id);
  }
}