// lib/domain/usecases/products/get_featured_products_usecase.dart
import 'package:storelytech/core/models/featured_product.dart';

import '../../../core/models/product.dart';
import '../../interfaces/repositories/product_repository.dart';
// import '../../entities/product.dart';



class GetFeaturedProductsUseCase {
  final ProductRepository repository;

  GetFeaturedProductsUseCase(this.repository);

  Future<List<FeaturedProduct>> execute() async {
    return await repository.getFeaturedProducts();
  }
}