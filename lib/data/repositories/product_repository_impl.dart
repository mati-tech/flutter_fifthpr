// lib/data/repositories/product_repository_impl.dart
import '../../core/models/category.dart';
import '../../core/models/product.dart';
import '../../domain/interfaces/repositories/product_repository.dart';
// import '../../domain/entities/product.dart';
// import '../../domain/entities/category.dart';
import '../datasources/Remote/mappers/category_mapper.dart';
import '../datasources/Remote/mappers/product_mapper.dart';
import '../datasources/Remote/product_api_datasource.dart';
// import '../datasources/product_api_datasource.dart';
// import '../mappers/product_mapper.dart';
// import '../mappers/category_mapper.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApiDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<List<Product>> getProducts({
    String? categoryId,
    int? limit,
    int? offset,
  }) async {
    // If categoryId provided, use category-specific API
    if (categoryId != null) {
      final dtos = await dataSource.getProductsByCategory(categoryId);
      return ProductMapper.toDomainList(dtos);
    }

    // Otherwise get all products
    final dtos = await dataSource.getProducts();
    return ProductMapper.toDomainList(dtos);
  }

  @override
  Future<Product> getProductById(String id) async {
    final dto = await dataSource.getProductById(id);
    return ProductMapper.toDomain(dto);
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final dtos = await dataSource.searchProducts(query);
    return ProductMapper.toDomainList(dtos);
  }

  @override
  Future<List<Product>> getFeaturedProducts() async {
    final dtos = await dataSource.getFeaturedProducts();
    return ProductMapper.toDomainList(dtos);
  }

  @override
  Future<List<Product>> getDiscountedProducts() async {
    final allProducts = await getProducts();
    return allProducts
        .where((product) => product.originalPrice != null &&
        product.originalPrice! > product.price)
        .toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    final dtos = await dataSource.getCategories();
    return dtos.map((dto) => CategoryMapper.toDomain(dto)).toList();
  }

  @override
  Future<Category> getCategoryById(String id) async {
    final dto = await dataSource.getCategoryById(id);
    return CategoryMapper.toDomain(dto);
  }
}