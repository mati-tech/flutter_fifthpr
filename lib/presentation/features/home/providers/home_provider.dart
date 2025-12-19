import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/featured_product.dart';
import '../../../../core/models/product.dart';
import '../../../../domain/usecases/product/get_featured_products_usecase.dart';
import '../../../../domain/usecases/product/get_products_usecase.dart';
import '../../../../domain/usecases/product/providers.dart';

/// =======================================================
/// HOME PROVIDER
/// =======================================================
final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final featuredUseCase = ref.watch(getFeaturedProductsUseCaseProvider);
  final productsUseCase = ref.watch(getProductsUseCaseProvider);
  return HomeNotifier(featuredUseCase, productsUseCase)..initialize();
});

/// =======================================================
/// HOME STATE NOTIFIER
/// =======================================================
class HomeNotifier extends StateNotifier<HomeState> {
  final GetFeaturedProductsUseCase _featuredUseCase;
  final GetProductsUseCase _productsUseCase;

  HomeNotifier(this._featuredUseCase, this._productsUseCase)
      : super(const HomeState());

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
  final List<Product> generalProducts;
  final bool isLoading;
  final bool isRefreshing;
  final String? error;

  const HomeState({
    this.featuredProducts = const [],
    this.generalProducts = const [],
    this.isLoading = false,
    this.isRefreshing = false,
    this.error,
  });

  HomeState copyWith({
    List<FeaturedProduct>? featuredProducts,
    List<Product>? generalProducts,
    bool? isLoading,
    bool? isRefreshing,
    String? error,
  }) =>
      HomeState(
        featuredProducts: featuredProducts ?? this.featuredProducts,
        generalProducts: generalProducts ?? this.generalProducts,
        isLoading: isLoading ?? this.isLoading,
        isRefreshing: isRefreshing ?? this.isRefreshing,
        error: error,
      );
}
