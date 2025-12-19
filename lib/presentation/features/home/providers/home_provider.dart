import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/featured_product.dart';
import '../../../../data/repositories/product_repository_impl.dart';
import '../../../../domain/usecases/product/get_featured_products_usecase.dart';
import '../../../../domain/usecases/product/providers.dart';
// import '../../../../domain/usecases/products/get_featured_products_usecase.dart';
// import '../../../shared/product_providers.dart';

/// =======================================================
/// DEPENDENCY PROVIDERS
/// =======================================================

// final _homeRepositoryProvider = Provider<ProductRepositoryImpl>((ref) {
//   return ref.watch(productRepositoryProvider);
// });
//
// final _getFeaturedProductsUseCaseProvider =
// Provider<GetFeaturedProductsUseCase>((ref) {
//   final repository = ref.watch(_homeRepositoryProvider);
//   return GetFeaturedProductsUseCase(repository);
// });
final homeProvider =
StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final useCase = ref.watch(getFeaturedProductsUseCaseProvider);
  return HomeNotifier(useCase)..initialize();
});

/// =======================================================
/// HOME STATE NOTIFIER
/// =======================================================
class HomeNotifier extends StateNotifier<HomeState> {
  final GetFeaturedProductsUseCase _useCase;

  HomeNotifier(this._useCase) : super(const HomeState());

  Future<void> initialize() async {
    state = state.copyWith(isLoading: true);
    try {
      final products = await _useCase.execute();
      state = state.copyWith(
        featuredProducts: products,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(isRefreshing: true);
    try {
      final products = await _useCase.execute();
      state = state.copyWith(
        featuredProducts: products,
        isRefreshing: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isRefreshing: false, error: e.toString());
    }
  }
}

class HomeState {
  final List<FeaturedProduct> featuredProducts;
  final bool isLoading;
  final bool isRefreshing;
  final String? error;

  const HomeState({
    this.featuredProducts = const [],
    this.isLoading = false,
    this.isRefreshing = false,
    this.error,
  });

  HomeState copyWith({
    List<FeaturedProduct>? featuredProducts,
    bool? isLoading,
    bool? isRefreshing,
    String? error,
  }) =>
      HomeState(
        featuredProducts: featuredProducts ?? this.featuredProducts,
        isLoading: isLoading ?? this.isLoading,
        isRefreshing: isRefreshing ?? this.isRefreshing,
        error: error,
      );
}