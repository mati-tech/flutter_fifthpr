import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import 'dto/product_dto.dart';
import 'dto/category_dto.dart';
import 'mappers/product_mapper.dart';
import 'mappers/category_mapper.dart';

/// Remote API data source for products
/// Handles HTTP requests to fetch products from remote API
abstract class ProductApiDataSource {
  /// Get all products from API
  /// Returns list of ProductDto
  /// Throws Exception if API call fails
  Future<List<ProductDto>> getProducts();

  /// Get product by ID from API
  /// [productId] - The unique identifier of the product
  /// Returns ProductDto if found
  /// Throws Exception if product not found or API call fails
  Future<ProductDto> getProductById(String productId);

  /// Search products from API
  /// [query] - Search term
  /// Returns list of matching ProductDto
  /// Throws Exception if API call fails
  Future<List<ProductDto>> searchProducts(String query);

  /// Get products by category from API
  /// [categoryId] - The category ID
  /// Returns list of ProductDto in the category
  /// Throws Exception if API call fails
  Future<List<ProductDto>> getProductsByCategory(String categoryId);

  /// Get featured products from API
  /// Returns list of featured ProductDto
  /// Throws Exception if API call fails
  Future<List<ProductDto>> getFeaturedProducts();

  /// Get all categories from API
  /// Returns list of CategoryDto
  /// Throws Exception if API call fails
  Future<List<CategoryDto>> getCategories();

  /// Get category by ID from API
  /// [categoryId] - The unique identifier of the category
  /// Returns CategoryDto if found
  /// Throws Exception if category not found or API call fails
  Future<CategoryDto> getCategoryById(String categoryId);
}



/// FastAPI-backed implementation using Dio
class FastApiProductApiDataSource implements ProductApiDataSource {
  final ApiClient _client;

  FastApiProductApiDataSource(this._client);

  Dio get _dio => _client.dio;

  @override
  Future<List<ProductDto>> getProducts() async {
    final response = await _dio.get('/products/');
    final data = response.data as List<dynamic>;
    return data.map((e) => ProductDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<ProductDto> getProductById(String productId) async {
    final response = await _dio.get('/products/$productId');
    return ProductDto.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<ProductDto>> searchProducts(String query) async {
    // If backend doesn't have search endpoint, filter client-side
    final all = await getProducts();
    final lower = query.toLowerCase();
    return all
        .where((p) =>
            p.name.toLowerCase().contains(lower) ||
            (p.description ?? '').toLowerCase().contains(lower) ||
            (p.brand ?? '').toLowerCase().contains(lower) ||
            p.category.toLowerCase().contains(lower))
        .toList();
  }

  @override
  Future<List<ProductDto>> getProductsByCategory(String categoryId) async {
    final response = await _dio.get(
      '/products/',
      queryParameters: {'category': categoryId},
    );
    final data = response.data as List<dynamic>;
    return data.map((e) => ProductDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<ProductDto>> getFeaturedProducts() async {
    // If backend doesn't support this, filter client-side
    final all = await getProducts();
    return all.where((p) => p.isFeatured).toList();
  }

  @override
  Future<List<CategoryDto>> getCategories() async {
    // If backend doesn't have dedicated categories endpoint,
    // derive categories from products
    final products = await getProducts();
    final categories = <String, CategoryDto>{};
    for (final p in products) {
      final key = p.category.toLowerCase();
      categories[key] = CategoryDto(
        id: key,
        name: p.category,
        imageUrl: '',
        productCount: (categories[key]?.productCount ?? 0) + 1,
      );
    }
    return categories.values.toList();
  }

  @override
  Future<CategoryDto> getCategoryById(String categoryId) async {
    final categories = await getCategories();
    return categories.firstWhere(
      (c) => c.id.toLowerCase() == categoryId.toLowerCase(),
      orElse: () => throw Exception('Category not found'),
    );
  }
}


