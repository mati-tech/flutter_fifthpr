import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/product.dart';

part 'home_provider.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {
  @override
  HomeState build() {
    final allProducts = _getInitialProducts();
    return HomeState(
      allProducts: allProducts,
      filteredProducts: allProducts,
      searchQuery: '',
      selectedCategory: 'All',
    );
  }
  List<Product> _getInitialProducts() {
    return [
      Product(
        id: '1',
        name: 'iPhone 14 Pro',
        description: 'Latest Apple smartphone with A16 Bionic chip',
        price: 999.99,
        originalPrice: 1199.99,
        imageUrl:
            'https://avatars.mds.yandex.net/i?id=2d95087bb036f8a35f39294795cd0618_l-10893744-images-thumbs&n=13',
        category: 'Smartphones',
        brand: 'Apple',
        rating: 4.8,
        reviewCount: 234,
        isFeatured: true,
        stock: 15,
      ),
      Product(
        id: '2',
        name: 'Samsung Galaxy S23',
        description: 'Powerful Android phone with great camera',
        price: 849.99,
        imageUrl:
            'https://avatars.mds.yandex.net/i?id=c6e497ad1c844685ed85a5290b64d397_l-5132380-images-thumbs&n=13',
        category: 'Smartphones',
        brand: 'Samsung',
        rating: 4.6,
        reviewCount: 189,
        isFeatured: false,
        stock: 10,
      ),
      Product(
        id: '3',
        name: 'MacBook Air M2',
        description: 'Lightweight laptop with Apple M2 chip',
        price: 1199.99,
        imageUrl:
            'https://avatars.mds.yandex.net/i?id=61dbdddf82c293561dc1cce1d10ef76c_l-10411335-images-thumbs&n=13',
        category: 'Laptops',
        brand: 'Apple',
        rating: 4.9,
        reviewCount: 156,
        isFeatured: true,
        stock: 8,
      ),
      Product(
        id: '4',
        name: 'Sony WH-1000XM4',
        description: 'Noise cancelling wireless headphones',
        price: 349.99,
        originalPrice: 399.99,
        imageUrl:
            'https://avatars.mds.yandex.net/i?id=6b11a8c4df68c9cab4b183796033b829385afce6-4257015-images-thumbs&n=13',
        category: 'Audio',
        brand: 'Sony',
        rating: 4.7,
        reviewCount: 312,
        isFeatured: true,
        stock: 25,
      ),
      Product(
        id: '5',
        name: 'iPad Pro 12.9"',
        description: 'Professional tablet with M1 chip',
        price: 1099.99,
        imageUrl:
            'https://www.eldorado.ru/storage/publication/0/59/rr83OQYDAn11EtsyzSZOsBQMXt13GtQyUSdlPiew.jpeg',
        category: 'Tablets',
        brand: 'Apple',
        rating: 4.8,
        reviewCount: 189,
        isFeatured: false,
        stock: 12,
      ),
      Product(
        id: '6',
        name: 'Apple Watch Series 8',
        description: 'Advanced smartwatch with health features',
        price: 399.99,
        originalPrice: 429.99,
        imageUrl:
            'https://avatars.mds.yandex.net/i?id=209be27fa39ee919f75395aff5282f20068be2cb-17799811-images-thumbs&n=13',
        category: 'Wearables',
        brand: 'Apple',
        rating: 4.5,
        reviewCount: 267,
        isFeatured: true,
        stock: 30,
      ),
      Product(
        id: '7',
        name: 'AirPods Pro',
        description: 'Wireless earbuds with active noise cancellation',
        price: 249.99,
        imageUrl:
            'https://avatars.mds.yandex.net/i?id=c32fe7ded71c6e07a7a22f0f15c0e86a5f46654b-16558525-images-thumbs&n=13',
        category: 'Audio',
        brand: 'Apple',
        rating: 4.6,
        reviewCount: 445,
        isFeatured: false,
        stock: 50,
      ),
      Product(
        id: '8',
        name: 'Dell XPS 13',
        description: 'Compact laptop with infinity edge display',
        price: 999.99,
        imageUrl:
            'https://avatars.mds.yandex.net/get-mpic/6259165/img_id1797926500859370432.jpeg/orig',
        category: 'Laptops',
        brand: 'Dell',
        rating: 4.4,
        reviewCount: 178,
        isFeatured: false,
        stock: 15,
      ),
      Product(
        id: '9',
        name: 'Google Pixel 7',
        description: 'Smartphone with advanced AI camera features',
        price: 599.99,
        imageUrl:
            'https://avatars.mds.yandex.net/i?id=a3f82dd928864081932b59384bc67c17_l-9211785-images-thumbs&n=13',
        category: 'Smartphones',
        brand: 'Google',
        rating: 4.3,
        reviewCount: 156,
        isFeatured: false,
        stock: 20,
      ),
      Product(
        id: '10',
        name: 'Bose QuietComfort 45',
        description: 'Wireless noise cancelling headphones',
        price: 329.99,
        imageUrl:
            'https://avatars.mds.yandex.net/i?id=1a78ff29828936dd84453870d4765e052e41e11c-10896978-images-thumbs&n=13',
        category: 'Audio',
        brand: 'Bose',
        rating: 4.5,
        reviewCount: 289,
        isFeatured: false,
        stock: 18,
      ),
    ];
  }

  void searchProducts(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void filterByCategory(String category) {
    state = state.copyWith(selectedCategory: category);
    _applyFilters();
  }

  void clearFilters() {
    state = state.copyWith(
      searchQuery: '',
      selectedCategory: 'All',
      filteredProducts: state.allProducts,
    );
  }

  List<Product> getProductsByCategory(String category) {
    return state.allProducts
        .where((product) => product.category == category)
        .toList();
  }

  List<Product> getProductsByBrand(String brand) {
    return state.allProducts
        .where((product) => product.brand == brand)
        .toList();
  }

  List<Product> getProductsInPriceRange(double minPrice, double maxPrice) {
    return state.allProducts
        .where((product) => product.price >= minPrice && product.price <= maxPrice)
        .toList();
  }

  List<Product> getDiscountedProducts() {
    return state.allProducts.where((product) => product.hasDiscount).toList();
  }

  List<Product> getHighlyRatedProducts() {
    return state.allProducts.where((product) => product.rating >= 4.5).toList();
  }

  Product? getProductById(String id) {
    try {
      return state.allProducts.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Product> getRelatedProducts(Product product, {int limit = 4}) {
    return state.allProducts
        .where((p) => p.category == product.category && p.id != product.id)
        .take(limit)
        .toList();
  }

  void _applyFilters() {
    List<Product> results = state.allProducts;

    // Apply search filter
    if (state.searchQuery.isNotEmpty) {
      results = results.where((product) {
        final name = product.name.toLowerCase();
        final description = product.description.toLowerCase();
        final category = product.category.toLowerCase();
        final brand = product.brand.toLowerCase();
        final query = state.searchQuery.toLowerCase();

        return name.contains(query) ||
            description.contains(query) ||
            category.contains(query) ||
            brand.contains(query);
      }).toList();
    }

    // Apply category filter
    if (state.selectedCategory != 'All') {
      results =
          results.where((product) => product.category == state.selectedCategory).toList();
    }

    state = state.copyWith(filteredProducts: results);
  }

  Future<void> refreshProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    _applyFilters();
  }

  void addProduct(Product product) {
    final currentProducts = List<Product>.from(state.allProducts);
    currentProducts.add(product);
    state = state.copyWith(allProducts: currentProducts);
    _applyFilters();
  }

  void updateProduct(String productId, Product updatedProduct) {
    final currentProducts = List<Product>.from(state.allProducts);
    final index = currentProducts.indexWhere((p) => p.id == productId);
    if (index != -1) {
      currentProducts[index] = updatedProduct;
      state = state.copyWith(allProducts: currentProducts);
      _applyFilters();
    }
  }

  void removeProduct(String productId) {
    final currentProducts = List<Product>.from(state.allProducts);
    currentProducts.removeWhere((p) => p.id == productId);
    state = state.copyWith(allProducts: currentProducts);
    _applyFilters();
  }
}

class HomeState {
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String searchQuery;
  final String selectedCategory;

  HomeState({
    required this.allProducts,
    required this.filteredProducts,
    required this.searchQuery,
    required this.selectedCategory,
  });

  List<Product> get featuredProducts {
    return allProducts.where((product) => product.isFeatured).toList();
  }

  List<String> get categories {
    final categories = allProducts.map((p) => p.category).toSet().toList();
    categories.insert(0, 'All');
    return categories;
  }

  List<String> get brands {
    return allProducts.map((p) => p.brand).toSet().toList();
  }

  bool get isSearchActive => searchQuery.isNotEmpty || selectedCategory != 'All';
  int get searchResultsCount => filteredProducts.length;

  HomeState copyWith({
    List<Product>? allProducts,
    List<Product>? filteredProducts,
    String? searchQuery,
    String? selectedCategory,
  }) {
    return HomeState(
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

