
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/product.dart';
import '../../../../data/datasources/api/product_api_datasource.dart';
import '../../../../data/repositories/product_repository_impl.dart';
import '../../../../domain/usecases/product/get_featured_products_usecase.dart';
import '../../../../domain/usecases/product/get_products_usecase.dart';
import '../../../../domain/usecases/product/search_products_usecase.dart';
import '../../../shared/api_client_provider.dart';


// ========== DEPENDENCY PROVIDERS ==========
final _homeDataSourceProvider = Provider<ProductApiDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return FastApiProductApiDataSource(apiClient);
});

final _homeRepositoryProvider = Provider<ProductRepositoryImpl>((ref) {
  final dataSource = ref.watch(_homeDataSourceProvider);
  return ProductRepositoryImpl(dataSource);
});

final _getProductsUseCaseProvider = Provider<GetProductsUseCase>((ref) {
  final repository = ref.watch(_homeRepositoryProvider);
  return GetProductsUseCase(repository);
});

final _getFeaturedProductsUseCaseProvider = Provider<GetFeaturedProductsUseCase>((ref) {
  final repository = ref.watch(_homeRepositoryProvider);
  return GetFeaturedProductsUseCase(repository);
});

final _searchProductsUseCaseProvider = Provider<SearchProductsUseCase>((ref) {
  final repository = ref.watch(_homeRepositoryProvider);
  return SearchProductsUseCase(repository);
});

// ========== HOME STATE PROVIDER ==========
class HomeNotifier extends StateNotifier<HomeState> {
  final Ref ref;

  HomeNotifier(this.ref) : super(const HomeState());

  Future<void> initialize() async {
    state = state.copyWith(isLoading: true);

    try {
      final getProductsUseCase = ref.read(_getProductsUseCaseProvider);
      final getFeaturedUseCase = ref.read(_getFeaturedProductsUseCaseProvider);

      final [allProducts, featuredProducts] = await Future.wait([
        getProductsUseCase.execute(),
        getFeaturedUseCase.execute(),
      ]);

      state = state.copyWith(
        allProducts: allProducts,
        filteredProducts: allProducts,
        featuredProducts: featuredProducts,
        isLoading: false,
      );
    } catch (error) {
      state = state.copyWith(
        error: error.toString(),
        isLoading: false,
      );
    }
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

  Future<void> refreshProducts() async {
    state = state.copyWith(isRefreshing: true);
    await Future.delayed(const Duration(seconds: 1));

    try {
      final useCase = ref.read(_getProductsUseCaseProvider);
      final products = await useCase.execute();

      state = state.copyWith(
        allProducts: products,
        filteredProducts: products,
        isRefreshing: false,
      );
      _applyFilters();
    } catch (error) {
      state = state.copyWith(
        error: error.toString(),
        isRefreshing: false,
      );
    }
  }

  // Get product by ID using our architecture
  Product? getProductById(String id) {
    try {
      return state.allProducts.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
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

  List<Product> getDiscountedProducts() {
    return state.allProducts.where((product) =>
    product.originalPrice != null && product.originalPrice! > product.price
    ).toList();
  }

  List<Product> getHighlyRatedProducts() {
    return state.allProducts.where((product) =>
    (product.rating ?? 0) >= 4.5
    ).toList();
  }

  List<Product> getRelatedProducts(Product product, {int limit = 4}) {
    return state.allProducts
        .where((p) => p.category == product.category && p.id != product.id)
        .take(limit)
        .toList();
  }

  void _applyFilters() {
    List<Product> results = state.allProducts;

    // Apply search filter (using our search use case for real API, mock for now)
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
      results = results.where((product) =>
      product.category == state.selectedCategory
      ).toList();
    }

    state = state.copyWith(filteredProducts: results);
  }

  // For admin functionality (optional)
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
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(ref)..initialize();
});

// ========== HOME STATE ==========
class HomeState {
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final List<Product> featuredProducts;
  final String searchQuery;
  final String selectedCategory;
  final bool isLoading;
  final bool isRefreshing;
  final String? error;

  const HomeState({
    this.allProducts = const [],
    this.filteredProducts = const [],
    this.featuredProducts = const [],
    this.searchQuery = '',
    this.selectedCategory = 'All',
    this.isLoading = false,
    this.isRefreshing = false,
    this.error,
  });

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
    List<Product>? featuredProducts,
    String? searchQuery,
    String? selectedCategory,
    bool? isLoading,
    bool? isRefreshing,
    String? error,
  }) {
    return HomeState(
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: error ?? this.error,
    );
  }
}