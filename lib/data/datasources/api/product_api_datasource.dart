import 'dto/product_dto.dart';
import 'dto/category_dto.dart';
import 'mappers/product_mapper.dart';
import 'mappers/category_mapper.dart';

/// Remote API data source for products
/// Handles HTTP requests to fetch products from remote API
/// In a real app, this would use http or dio package
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

/// Mock implementation of ProductApiDataSource
// /// In production, replace with actual HTTP client implementation
// class ProductApiDataSourceImpl implements ProductApiDataSource {
//   // Mock data - replace with actual API calls
//   final List<ProductDto> _mockProducts = [
//     ProductDto(
//       id: '1',
//       name: 'iPhone 14 Pro',
//       description: 'Latest Apple smartphone with A16 Bionic chip',
//       price: 999.99,
//       originalPrice: 1199.99,
//       imageUrl:
//           'https://avatars.mds.yandex.net/i?id=2d95087bb036f8a35f39294795cd0618_l-10893744-images-thumbs&n=13',
//       category: 'smartphones',
//       brand: 'Apple',
//       rating: 4.8,
//       reviewCount: 234,
//       isFeatured: true,
//       stock: 15, categoryId: '', stockQuantity: null,
//     ),
//     ProductDto(
//       id: '2',
//       name: 'Samsung Galaxy S23',
//       description: 'Powerful Android phone with great camera',
//       price: 849.99,
//       imageUrl:
//           'https://avatars.mds.yandex.net/i?id=c6e497ad1c844685ed85a5290b64d397_l-5132380-images-thumbs&n=13',
//       category: 'smartphones',
//       brand: 'Samsung',
//       rating: 4.6,
//       reviewCount: 189,
//       isFeatured: false,
//       stock: 10, categoryId: '', stockQuantity: null, createdAt: '',
//     ),
//     ProductDto(
//       id: '3',
//       name: 'MacBook Air M2',
//       description: 'Lightweight laptop with Apple M2 chip',
//       price: 1199.99,
//       imageUrl:
//           'https://avatars.mds.yandex.net/i?id=61dbdddf82c293561dc1cce1d10ef76c_l-10411335-images-thumbs&n=13',
//       category: 'laptops',
//       brand: 'Apple',
//       rating: 4.9,
//       reviewCount: 156,
//       isFeatured: true,
//       stock: 8,
//     ),
//     ProductDto(
//       id: '4',
//       name: 'Sony WH-1000XM4',
//       description: 'Premium noise-cancelling headphones',
//       price: 349.99,
//       originalPrice: 399.99,
//       imageUrl:
//           'https://avatars.mds.yandex.net/i?id=1a78ff29828936dd84453870d4765e052e41e11c-10896978-images-thumbs&n=13',
//       category: 'audio',
//       brand: 'Sony',
//       rating: 4.7,
//       reviewCount: 312,
//       isFeatured: true,
//       stock: 20,
//     ),
//     ProductDto(
//       id: '5',
//       name: 'iPad Pro 12.9"',
//       description: 'Professional tablet with M2 chip',
//       price: 1099.99,
//       imageUrl:
//           'https://avatars.mds.yandex.net/i?id=a3f82dd928864081932b59384bc67c17_l-9211785-images-thumbs&n=13',
//       category: 'tablets',
//       brand: 'Apple',
//       rating: 4.8,
//       reviewCount: 178,
//       isFeatured: false,
//       stock: 12,
//     ),
//   ];
//
//   final List<CategoryDto> _mockCategories = [
//     CategoryDto(id: 'smartphones', name: 'Smartphones', description: 'Mobile phones'),
//     CategoryDto(id: 'laptops', name: 'Laptops', description: 'Portable computers'),
//     CategoryDto(id: 'tablets', name: 'Tablets', description: 'Touchscreen devices'),
//     CategoryDto(id: 'audio', name: 'Audio', description: 'Headphones and speakers'),
//   ];
//
//   @override
//   Future<List<ProductDto>> getProducts() async {
//     // Simulate network delay
//     await Future.delayed(const Duration(milliseconds: 500));
//     return List.from(_mockProducts);
//   }
//
//   @override
//   Future<ProductDto> getProductById(String productId) async {
//     await Future.delayed(const Duration(milliseconds: 300));
//     final product = _mockProducts.firstWhere(
//       (p) => p.id == productId,
//       orElse: () => throw Exception('Product not found: $productId'),
//     );
//     return product;
//   }
//
//   @override
//   Future<List<ProductDto>> searchProducts(String query) async {
//     await Future.delayed(const Duration(milliseconds: 400));
//     final lowerQuery = query.toLowerCase();
//     return _mockProducts.where((product) {
//       return product.name.toLowerCase().contains(lowerQuery) ||
//           product.description.toLowerCase().contains(lowerQuery) ||
//           product.brand.toLowerCase().contains(lowerQuery);
//     }).toList();
//   }
//
//   @override
//   Future<List<ProductDto>> getProductsByCategory(String categoryId) async {
//     await Future.delayed(const Duration(milliseconds: 400));
//     return _mockProducts
//         .where((product) => product.category.toLowerCase() == categoryId.toLowerCase())
//         .toList();
//   }
//
//   @override
//   Future<List<ProductDto>> getFeaturedProducts() async {
//     await Future.delayed(const Duration(milliseconds: 300));
//     return _mockProducts.where((product) => product.isFeatured).toList();
//   }
//
//   @override
//   Future<List<CategoryDto>> getCategories() async {
//     await Future.delayed(const Duration(milliseconds: 200));
//     return List.from(_mockCategories);
//   }
//
//   @override
//   Future<CategoryDto> getCategoryById(String categoryId) async {
//     await Future.delayed(const Duration(milliseconds: 200));
//     final category = _mockCategories.firstWhere(
//       (c) => c.id == categoryId,
//       orElse: () => throw Exception('Category not found: $categoryId'),
//     );
//     return category;
//   }
// }

// lib/data/datasources/mock_product_api_datasource.dart
// import 'product_api_datasource.dart';
// import '../dtos/product_dto.dart';
// import '../dtos/category_dto.dart';

class MockProductApiDataSource implements ProductApiDataSource {
  // Your mock products converted to DTOs
  final List<ProductDto> _mockProducts = [
    ProductDto(
      id: '1',
      name: 'iPhone 14 Pro',
      description: 'Latest Apple smartphone with A16 Bionic chip',
      price: 999.99,
      originalPrice: 1199.99,
      imageUrl: 'https://avatars.mds.yandex.net/i?id=2d95087bb036f8a35f39294795cd0618_l-10893744-images-thumbs&n=13',
      category: 'Smartphones',
      brand: 'Apple',
      rating: 4.8,
      reviewCount: 234,
      isFeatured: true,
      stock: 15,
    ),
    ProductDto(
      id: '2',
      name: 'Samsung Galaxy S23',
      description: 'Powerful Android phone with great camera',
      price: 849.99,
      imageUrl: 'https://avatars.mds.yandex.net/i?id=c6e497ad1c844685ed85a5290b64d397_l-5132380-images-thumbs&n=13',
      category: 'Smartphones',
      brand: 'Samsung',
      rating: 4.6,
      reviewCount: 189,
      isFeatured: false,
      stock: 10,
    ),
    ProductDto(
      id: '3',
      name: 'MacBook Air M2',
      description: 'Lightweight laptop with Apple M2 chip',
      price: 1199.99,
      imageUrl: 'https://avatars.mds.yandex.net/i?id=61dbdddf82c293561dc1cce1d10ef76c_l-10411335-images-thumbs&n=13',
      category: 'Laptops',
      brand: 'Apple',
      rating: 4.9,
      reviewCount: 156,
      isFeatured: true,
      stock: 8,
    ),
    ProductDto(
      id: '4',
      name: 'Sony WH-1000XM4',
      description: 'Noise cancelling wireless headphones',
      price: 349.99,
      originalPrice: 399.99,
      imageUrl: 'https://avatars.mds.yandex.net/i?id=6b11a8c4df68c9cab4b183796033b829385afce6-4257015-images-thumbs&n=13',
      category: 'Audio',
      brand: 'Sony',
      rating: 4.7,
      reviewCount: 312,
      isFeatured: true,
      stock: 25,
    ),
    ProductDto(
      id: '5',
      name: 'iPad Pro 12.9"',
      description: 'Professional tablet with M1 chip',
      price: 1099.99,
      imageUrl: 'https://www.eldorado.ru/storage/publication/0/59/rr83OQYDAn11EtsyzSZOsBQMXt13GtQyUSdlPiew.jpeg',
      category: 'Tablets',
      brand: 'Apple',
      rating: 4.8,
      reviewCount: 189,
      isFeatured: false,
      stock: 12,
    ),
    ProductDto(
      id: '6',
      name: 'Apple Watch Series 8',
      description: 'Advanced smartwatch with health features',
      price: 399.99,
      originalPrice: 429.99,
      imageUrl: 'https://avatars.mds.yandex.net/i?id=209be27fa39ee919f75395aff5282f20068be2cb-17799811-images-thumbs&n=13',
      category: 'Wearables',
      brand: 'Apple',
      rating: 4.5,
      reviewCount: 267,
      isFeatured: true,
      stock: 30,
    ),
    ProductDto(
      id: '7',
      name: 'AirPods Pro',
      description: 'Wireless earbuds with active noise cancellation',
      price: 249.99,
      imageUrl: 'https://avatars.mds.yandex.net/i?id=c32fe7ded71c6e07a7a22f0f15c0e86a5f46654b-16558525-images-thumbs&n=13',
      category: 'Audio',
      brand: 'Apple',
      rating: 4.6,
      reviewCount: 445,
      isFeatured: false,
      stock: 50,
    ),
    ProductDto(
      id: '8',
      name: 'Dell XPS 13',
      description: 'Compact laptop with infinity edge display',
      price: 999.99,
      imageUrl: 'https://avatars.mds.yandex.net/get-mpic/6259165/img_id1797926500859370432.jpeg/orig',
      category: 'Laptops',
      brand: 'Dell',
      rating: 4.4,
      reviewCount: 178,
      isFeatured: false,
      stock: 15,
    ),
    ProductDto(
      id: '9',
      name: 'Google Pixel 7',
      description: 'Smartphone with advanced AI camera features',
      price: 599.99,
      imageUrl: 'https://avatars.mds.yandex.net/i?id=a3f82dd928864081932b59384bc67c17_l-9211785-images-thumbs&n=13',
      category: 'Smartphones',
      brand: 'Google',
      rating: 4.3,
      reviewCount: 156,
      isFeatured: false,
      stock: 20,
    ),
    ProductDto(
      id: '10',
      name: 'Bose QuietComfort 45',
      description: 'Wireless noise cancelling headphones',
      price: 329.99,
      imageUrl: 'https://avatars.mds.yandex.net/i?id=1a78ff29828936dd84453870d4765e052e41e11c-10896978-images-thumbs&n=13',
      category: 'Audio',
      brand: 'Bose',
      rating: 4.5,
      reviewCount: 289,
      isFeatured: false,
      stock: 18,
    ),
  ];

  // Mock categories
  final List<CategoryDto> _mockCategories = [
    CategoryDto(
      id: 'smartphones',
      name: 'Smartphones',
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/2972/2972425.png',
      productCount: 3,
    ),
    CategoryDto(
      id: 'laptops',
      name: 'Laptops',
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/428/428001.png',
      productCount: 2,
    ),
    CategoryDto(
      id: 'audio',
      name: 'Audio',
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/2972/2972418.png',
      productCount: 3,
    ),
    CategoryDto(
      id: 'tablets',
      name: 'Tablets',
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/4290/4290854.png',
      productCount: 1,
    ),
    CategoryDto(
      id: 'wearables',
      name: 'Wearables',
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/3082/3082027.png',
      productCount: 1,
    ),
  ];

  // Simulate network delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<List<ProductDto>> getProducts() async {
    await _simulateDelay();
    return _mockProducts;
  }

  @override
  Future<ProductDto> getProductById(String productId) async {
    await _simulateDelay();

    final product = _mockProducts.firstWhere(
          (p) => p.id == productId,
      orElse: () => throw Exception('Product not found'),
    );

    return product;
  }

  @override
  Future<List<ProductDto>> searchProducts(String query) async {
    await _simulateDelay();

    if (query.isEmpty) return [];

    final lowerQuery = query.toLowerCase();
    return _mockProducts
        .where((product) =>
    product.name.toLowerCase().contains(lowerQuery) ||
        product.description.toLowerCase().contains(lowerQuery) ||
        product.brand.toLowerCase().contains(lowerQuery) ||
        product.category.toLowerCase().contains(lowerQuery))
        .toList();
  }

  @override
  Future<List<ProductDto>> getProductsByCategory(String categoryId) async {
    await _simulateDelay();

    return _mockProducts
        .where((product) => product.category.toLowerCase() == categoryId.toLowerCase())
        .toList();
  }

  @override
  Future<List<ProductDto>> getFeaturedProducts() async {
    await _simulateDelay();

    return _mockProducts
        .where((product) => product.isFeatured)
        .toList();
  }

  @override
  Future<List<CategoryDto>> getCategories() async {
    await _simulateDelay();
    return _mockCategories;
  }

  @override
  Future<CategoryDto> getCategoryById(String categoryId) async {
    await _simulateDelay();

    final category = _mockCategories.firstWhere(
          (c) => c.id.toLowerCase() == categoryId.toLowerCase(),
      orElse: () => throw Exception('Category not found'),
    );

    return category;
  }
}

