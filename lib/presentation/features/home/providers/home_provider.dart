import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/featured_product.dart';
import '../../../../core/models/product.dart';
import '../../../../core/models/product_detail.dart';
import '../../../../data/repositories/providers.dart';
import '../../../../domain/usecases/product/get_featured_products_usecase.dart';
import '../../../../domain/usecases/product/get_product_by_id_usecase.dart';
import '../../../../domain/usecases/product/get_products_usecase.dart';
// import '../../../../domain/usecases/product/get_products_by_id_usecase.dart'; // Добавьте
import '../../../../domain/usecases/product/providers.dart';
import '../../../../domain/usecases/product/search_products_usecase.dart';

/// =======================================================
/// HOME PROVIDER
/// =======================================================
final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final productsUseCase = ref.watch(getProductsUseCaseProvider);
  final productByIdUseCase = ref.watch(getProductsByIdUseCaseProvider);
  final searchUseCase = ref.watch(searchProductsUseCaseProvider);

  return HomeNotifier(productsUseCase, productByIdUseCase, searchUseCase)..initialize();
});


final getProductsByIdUseCaseProvider = Provider<GetProductsByIdUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductsByIdUseCase(repository);
});

/// =======================================================
/// HOME STATE NOTIFIER
/// =======================================================
class HomeNotifier extends StateNotifier<HomeState> {
  final GetProductsUseCase _productsUseCase;
  final GetProductsByIdUseCase _productByIdUseCase;
  final SearchProductsUseCase _searchUseCase;

  HomeNotifier(
      this._productsUseCase,
      this._productByIdUseCase,
      this._searchUseCase,
      ) : super(const HomeState());

  /// Load initial products
  Future<void> initialize() async {
    state = state.copyWith(isLoading: true);
    try {
      final products = await _productsUseCase.execute();
      state = state.copyWith(products: products, isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Search products
  Future<void> searchProducts(String query) async {
    state = state.copyWith(isLoading: true);
    try {
      final results = await _searchUseCase.execute(query);
      state = state.copyWith(products: results, isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Get product by ID
  Future<Product?> getProductById(int id) async {
    try {
      final product = await _productByIdUseCase.execute(id);
      state = state.copyWith(selectedProduct: product);
      return product;
    } catch (_) {
      return null;
    }
  }

  /// Refresh products
  Future<void> refresh() async {
    state = state.copyWith(isRefreshing: true);
    try {
      final products = await _productsUseCase.execute();
      state = state.copyWith(products: products, isRefreshing: false, error: null);
    } catch (e) {
      state = state.copyWith(isRefreshing: false, error: e.toString());
    }
  }
}

/// =======================================================
/// HOME STATE
/// =======================================================
// class HomeState {
//   final List<FeaturedProduct> featuredProducts;
//   final List<Product> generalProducts;
//   final ProductDetail? selectedProduct; // Добавьте для хранения выбранного продукта
//   final bool isLoading;
//   final bool isRefreshing;
//   final String? error;
//
//   const HomeState({
//     this.featuredProducts = const [],
//     this.generalProducts = const [],
//     this.selectedProduct,
//     this.isLoading = false,
//     this.isRefreshing = false,
//     this.error,
//   });
//
//   HomeState copyWith({
//     List<FeaturedProduct>? featuredProducts,
//     List<Product>? generalProducts,
//     ProductDetail? selectedProduct, // Добавьте
//     bool? isLoading,
//     bool? isRefreshing,
//     String? error,
//   }) =>
//       HomeState(
//         featuredProducts: featuredProducts ?? this.featuredProducts,
//         generalProducts: generalProducts ?? this.generalProducts,
//         selectedProduct: selectedProduct ?? this.selectedProduct,
//         isLoading: isLoading ?? this.isLoading,
//         isRefreshing: isRefreshing ?? this.isRefreshing,
//         error: error,
//       );
// }
class HomeState {
  final List<Product> products;
  final Product? selectedProduct;
  final bool isLoading;
  final bool isRefreshing;
  final String? error;

  const HomeState({
    this.products = const [],
    this.selectedProduct,
    this.isLoading = false,
    this.isRefreshing = false,
    this.error,
  });

  HomeState copyWith({
    List<Product>? products,
    Product? selectedProduct,
    bool? isLoading,
    bool? isRefreshing,
    String? error,
  }) {
    return HomeState(
      products: products ?? this.products,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: error,
    );
  }
}
