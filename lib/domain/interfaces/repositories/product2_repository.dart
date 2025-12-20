import '../../../core/models/product2.dart';

abstract class Product2Repository {

  Future<List<Product2>> getProducts();
  // Future<List<FeaturedProduct>> getProducts();
  // Future<ProductDetail> getProductDetail(int id);
  //
  // Future<User> getUserDetail(int id);
  //
  // Future<User> deleteUser(int id);

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