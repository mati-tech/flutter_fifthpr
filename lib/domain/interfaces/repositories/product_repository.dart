import '../../../core/models/product.dart';
import '../../../core/models/category.dart';

/// Abstract repository interface for product operations
/// Domain layer - no Flutter, HTTP, or JSON dependencies
abstract class ProductRepository {

  Future<List<Product>> getProducts();
  // Get product by ID
  Future<Product> getProductById(String id);

  // Search products
  Future<List<Product>> searchProducts(String query);

  // Get featured products
  Future<List<Product>> getFeaturedProducts();

  // Get products on sale
  Future<List<Product>> getDiscountedProducts();

  // Get all categories
  Future<List<Category>> getCategories();

// Get category by ID
  Future<Category> getCategoryById(String id);
}

