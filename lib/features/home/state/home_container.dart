// import 'package:flutter/material.dart';
// import '../models/product.dart';
//
// class HomeContainer extends ChangeNotifier {
//   // Private list of all products
//   final List<Product> _allProducts = [
//     Product(
//       id: '1',
//       name: 'iPhone 14 Pro',
//       description: 'Latest Apple smartphone with A16 Bionic chip',
//       price: 999.99,
//       originalPrice: 1199.99,
//       imageUrl: 'https://avatars.mds.yandex.net/i?id=2d95087bb036f8a35f39294795cd0618_l-10893744-images-thumbs&n=13',
//       category: 'Smartphones',
//       brand: 'Apple',
//       rating: 4.8,
//       reviewCount: 234,
//       isFeatured: true,
//       stock: 15,
//     ),
//     Product(
//       id: '2',
//       name: 'Samsung Galaxy S23',
//       description: 'Powerful Android phone with great camera',
//       price: 849.99,
//       imageUrl: 'https://avatars.mds.yandex.net/i?id=c6e497ad1c844685ed85a5290b64d397_l-5132380-images-thumbs&n=13',
//       category: 'Smartphones',
//       brand: 'Samsung',
//       rating: 4.6,
//       reviewCount: 189,
//       isFeatured: false,
//       stock: 10,
//     ),
//     Product(
//       id: '3',
//       name: 'MacBook Air M2',
//       description: 'Lightweight laptop with Apple M2 chip',
//       price: 1199.99,
//       imageUrl: 'https://avatars.mds.yandex.net/i?id=61dbdddf82c293561dc1cce1d10ef76c_l-10411335-images-thumbs&n=13',
//       category: 'Laptops',
//       brand: 'Apple',
//       rating: 4.9,
//       reviewCount: 156,
//       isFeatured: true,
//       stock: 8,
//     ),
//     Product(
//       id: '4',
//       name: 'Sony WH-1000XM4',
//       description: 'Noise cancelling wireless headphones',
//       price: 349.99,
//       originalPrice: 399.99,
//       imageUrl: 'https://avatars.mds.yandex.net/i?id=6b11a8c4df68c9cab4b183796033b829385afce6-4257015-images-thumbs&n=13',
//       category: 'Audio',
//       brand: 'Sony',
//       rating: 4.7,
//       reviewCount: 312,
//       isFeatured: true,
//       stock: 25,
//     ),
//     Product(
//       id: '5',
//       name: 'iPad Pro 12.9"',
//       description: 'Professional tablet with M1 chip',
//       price: 1099.99,
//       imageUrl: 'https://www.eldorado.ru/storage/publication/0/59/rr83OQYDAn11EtsyzSZOsBQMXt13GtQyUSdlPiew.jpeg',
//       category: 'Tablets',
//       brand: 'Apple',
//       rating: 4.8,
//       reviewCount: 189,
//       isFeatured: false,
//       stock: 12,
//     ),
//     Product(
//       id: '6',
//       name: 'Apple Watch Series 8',
//       description: 'Advanced smartwatch with health features',
//       price: 399.99,
//       originalPrice: 429.99,
//       imageUrl: 'https://avatars.mds.yandex.net/i?id=209be27fa39ee919f75395aff5282f20068be2cb-17799811-images-thumbs&n=13',
//       category: 'Wearables',
//       brand: 'Apple',
//       rating: 4.5,
//       reviewCount: 267,
//       isFeatured: true,
//       stock: 30,
//     ),
//     Product(
//       id: '7',
//       name: 'AirPods Pro',
//       description: 'Wireless earbuds with active noise cancellation',
//       price: 249.99,
//       imageUrl: 'https://avatars.mds.yandex.net/i?id=c32fe7ded71c6e07a7a22f0f15c0e86a5f46654b-16558525-images-thumbs&n=13',
//       category: 'Audio',
//       brand: 'Apple',
//       rating: 4.6,
//       reviewCount: 445,
//       isFeatured: false,
//       stock: 50,
//     ),
//     Product(
//       id: '8',
//       name: 'Dell XPS 13',
//       description: 'Compact laptop with infinity edge display',
//       price: 999.99,
//       imageUrl: 'https://avatars.mds.yandex.net/get-mpic/6259165/img_id1797926500859370432.jpeg/orig',
//       category: 'Laptops',
//       brand: 'Dell',
//       rating: 4.4,
//       reviewCount: 178,
//       isFeatured: false,
//       stock: 15,
//     ),
//     Product(
//       id: '9',
//       name: 'Google Pixel 7',
//       description: 'Smartphone with advanced AI camera features',
//       price: 599.99,
//       imageUrl: 'https://avatars.mds.yandex.net/i?id=a3f82dd928864081932b59384bc67c17_l-9211785-images-thumbs&n=13',
//       category: 'Smartphones',
//       brand: 'Google',
//       rating: 4.3,
//       reviewCount: 156,
//       isFeatured: false,
//       stock: 20,
//     ),
//     Product(
//       id: '10',
//       name: 'Bose QuietComfort 45',
//       description: 'Wireless noise cancelling headphones',
//       price: 329.99,
//       imageUrl: 'https://avatars.mds.yandex.net/i?id=1a78ff29828936dd84453870d4765e052e41e11c-10896978-images-thumbs&n=13',
//       category: 'Audio',
//       brand: 'Bose',
//       rating: 4.5,
//       reviewCount: 289,
//       isFeatured: false,
//       stock: 18,
//     ),
//   ];
//
//   // Private state variables
//   List<Product> _filteredProducts = [];
//   String _searchQuery = '';
//   String _selectedCategory = 'All';
//
//   // Constructor
//   HomeContainer() {
//     _filteredProducts = _allProducts;
//   }
//
//   // Public getters
//   List<Product> get allProducts => _allProducts;
//   List<Product> get filteredProducts => _filteredProducts;
//   String get searchQuery => _searchQuery;
//   String get selectedCategory => _selectedCategory;
//
//   // Get featured products
//   List<Product> get featuredProducts {
//     return _allProducts.where((product) => product.isFeatured).toList();
//   }
//
//   // Get all available categories
//   List<String> get categories {
//     final categories = _allProducts.map((p) => p.category).toSet().toList();
//     categories.insert(0, 'All');
//     return categories;
//   }
//
//   // Search products by query
//   void searchProducts(String query) {
//     _searchQuery = query;
//     _applyFilters();
//     notifyListeners();
//   }
//
//   // Filter products by category
//   void filterByCategory(String category) {
//     _selectedCategory = category;
//     _applyFilters();
//     notifyListeners();
//   }
//
//   // Clear all filters and search
//   void clearFilters() {
//     _searchQuery = '';
//     _selectedCategory = 'All';
//     _filteredProducts = _allProducts;
//     notifyListeners();
//   }
//
//   // Get products by specific category
//   List<Product> getProductsByCategory(String category) {
//     return _allProducts.where((product) => product.category == category).toList();
//   }
//
//   // Get products by brand
//   List<Product> getProductsByBrand(String brand) {
//     return _allProducts.where((product) => product.brand == brand).toList();
//   }
//
//   // Get products in price range
//   List<Product> getProductsInPriceRange(double minPrice, double maxPrice) {
//     return _allProducts.where((product) =>
//     product.price >= minPrice && product.price <= maxPrice
//     ).toList();
//   }
//
//   // Get products with discount
//   List<Product> getDiscountedProducts() {
//     return _allProducts.where((product) => product.hasDiscount).toList();
//   }
//
//   // Get products with high rating (4.5+)
//   List<Product> getHighlyRatedProducts() {
//     return _allProducts.where((product) => product.rating >= 4.5).toList();
//   }
//
//   // Find product by ID
//   Product? getProductById(String id) {
//     try {
//       return _allProducts.firstWhere((product) => product.id == id);
//     } catch (e) {
//       return null;
//     }
//   }
//
//   // Get related products (same category, excluding current product)
//   List<Product> getRelatedProducts(Product product, {int limit = 4}) {
//     return _allProducts
//         .where((p) => p.category == product.category && p.id != product.id)
//         .take(limit)
//         .toList();
//   }
//
//   // Private method to apply all active filters
//   void _applyFilters() {
//     List<Product> results = _allProducts;
//
//     // Apply search filter
//     if (_searchQuery.isNotEmpty) {
//       results = results.where((product) {
//         final name = product.name.toLowerCase();
//         final description = product.description.toLowerCase();
//         final category = product.category.toLowerCase();
//         final brand = product.brand.toLowerCase();
//         final query = _searchQuery.toLowerCase();
//
//         return name.contains(query) ||
//             description.contains(query) ||
//             category.contains(query) ||
//             brand.contains(query);
//       }).toList();
//     }
//
//     // Apply category filter
//     if (_selectedCategory != 'All') {
//       results = results.where((product) => product.category == _selectedCategory).toList();
//     }
//
//     _filteredProducts = results;
//   }
//
//   // Check if search is active
//   bool get isSearchActive => _searchQuery.isNotEmpty || _selectedCategory != 'All';
//
//   // Get search results count
//   int get searchResultsCount => _filteredProducts.length;
//
//   // Get available brands
//   List<String> get brands {
//     return _allProducts.map((p) => p.brand).toSet().toList();
//   }
//
//   // Refresh products (for future API integration)
//   Future<void> refreshProducts() async {
//     // Simulate API call delay
//     await Future.delayed(const Duration(seconds: 1));
//     _applyFilters();
//     notifyListeners();
//   }
//
//   // Add new product (for admin functionality)
//   void addProduct(Product product) {
//     _allProducts.add(product);
//     _applyFilters();
//     notifyListeners();
//   }
//
//   // Update existing product
//   void updateProduct(String productId, Product updatedProduct) {
//     final index = _allProducts.indexWhere((p) => p.id == productId);
//     if (index != -1) {
//       _allProducts[index] = updatedProduct;
//       _applyFilters();
//       notifyListeners();
//     }
//   }
//
//   // Remove product
//   void removeProduct(String productId) {
//     _allProducts.removeWhere((p) => p.id == productId);
//     _applyFilters();
//     notifyListeners();
//   }
// }