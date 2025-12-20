


import '../../../core/models/product.dart';
import '../../interfaces/repositories/product_repository.dart';

class SearchProductsUseCase {
  final ProductRepository repository;

  SearchProductsUseCase(this.repository);

  Future<List<Product>> execute(String query) async {
    return await repository.searchProducts(query);
  }
}
