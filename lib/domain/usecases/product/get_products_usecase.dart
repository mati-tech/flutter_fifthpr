import '../../../core/models/product.dart';
import '../../interfaces/repositories/product_repository.dart';

/// Use case for getting all products
/// Single responsibility: Fetch all available products
class GetProductsUseCase {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  /// Execute the use case
  /// Returns a list of all products
  /// Throws Exception if the operation fails
  Future<List<Product>> execute() async {
    try {
      return await _repository.getProducts();
    } catch (e) {
      throw Exception('Failed to fetch products: ${e.toString()}');
    }
  }
}

