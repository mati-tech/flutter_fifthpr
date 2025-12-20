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

/// =======================================================
/// HOME PROVIDER
/// =======================================================
final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final featuredUseCase = ref.watch(getFeaturedProductsUseCaseProvider);
  final productsUseCase = ref.watch(getProductsUseCaseProvider);
  final productByIdUseCase = ref.watch(getProductsByIdUseCaseProvider); // Добавьте
  return HomeNotifier(featuredUseCase, productsUseCase, productByIdUseCase) // Изменить
    ..initialize();
});

final getProductsByIdUseCaseProvider = Provider<GetProductsByIdUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductsByIdUseCase(repository);
});

/// =======================================================
/// HOME STATE NOTIFIER
/// =======================================================
class HomeNotifier extends StateNotifier<HomeState> {
  final GetFeaturedProductsUseCase _featuredUseCase;
  final GetProductsUseCase _productsUseCase;
  final GetProductsByIdUseCase _productByIdUseCase; // Добавьте

  HomeNotifier(
      this._featuredUseCase,
      this._productsUseCase,
      this._productByIdUseCase, // Добавьте
      ) : super(const HomeState());

  /// Load both featured and general products
  Future<void> initialize() async {
    state = state.copyWith(isLoading: true);
    try {
      final featured = await _featuredUseCase.execute();
      final products = await _productsUseCase.execute();
      state = state.copyWith(
        featuredProducts: featured,
        generalProducts: products,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Get product by ID
  Future<ProductDetail?> getProductById(int id) async { // Новый метод
    try {
      final product = await _productByIdUseCase.execute(id);
      // Сохраняем выбранный продукт в state
      state = state.copyWith(selectedProduct: product);
      return product;
    } catch (e) {
      print('Error loading product $id: $e');
      return null;
    }
  }

  /// Refresh both lists
  Future<void> refresh() async {
    state = state.copyWith(isRefreshing: true);
    try {
      final featured = await _featuredUseCase.execute();
      final products = await _productsUseCase.execute();
      state = state.copyWith(
        featuredProducts: featured,
        generalProducts: products,
        isRefreshing: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isRefreshing: false, error: e.toString());
    }
  }
}

/// =======================================================
/// HOME STATE
/// =======================================================
class HomeState {
  final List<FeaturedProduct> featuredProducts;
  final List<FeaturedProduct> generalProducts;
  final ProductDetail? selectedProduct; // Добавьте для хранения выбранного продукта
  final bool isLoading;
  final bool isRefreshing;
  final String? error;

  const HomeState({
    this.featuredProducts = const [],
    this.generalProducts = const [],
    this.selectedProduct,
    this.isLoading = false,
    this.isRefreshing = false,
    this.error,
  });

  HomeState copyWith({
    List<FeaturedProduct>? featuredProducts,
    List<FeaturedProduct>? generalProducts,
    ProductDetail? selectedProduct, // Добавьте
    bool? isLoading,
    bool? isRefreshing,
    String? error,
  }) =>
      HomeState(
        featuredProducts: featuredProducts ?? this.featuredProducts,
        generalProducts: generalProducts ?? this.generalProducts,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        isLoading: isLoading ?? this.isLoading,
        isRefreshing: isRefreshing ?? this.isRefreshing,
        error: error,
      );
}