


import '../../../core/models/product.dart';

abstract class GeneralProductRepository {

  // Future<List<Product>> g();
Future<List<Product>> getProducts();
// Get product by ID
//   Future<Product> getProductById(String id);
//
//   // Search products
//   Future<List<Product>> searchProducts(String query);
//
//   // Get featured products
//   Future<List<Product>> getFeaturedProducts();
//
//   // Get products on sale
//   Future<List<Product>> getDiscountedProducts();
//
//   // Get all categories
//   Future<List<Category>> getCategories();
//
// // Get category by ID
//   Future<Category> getCategoryById(String id);
}