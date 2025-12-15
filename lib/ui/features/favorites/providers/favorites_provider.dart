// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import '../../../../core/models/favorite_item.dart';
// import '../../../../core/models/product.dart';
// // import '../models/favorite_item.dart';
// // import '../../home/models/product.dart';
//
// part 'favorites_provider.g.dart';
//
// @riverpod
// class FavoritesNotifier extends _$FavoritesNotifier {
//   @override
//   FavoritesState build() {
//     return FavoritesState(favorites: []);
//   }
//
//   bool isProductFavorite(String productId) {
//     return state.favorites.any((item) => item.product.id == productId);
//   }
//
//   void addToFavorites(Product product) {
//     if (!isProductFavorite(product.id)) {
//       final currentFavorites = List<FavoriteItem>.from(state.favorites);
//       currentFavorites.add(FavoriteItem(
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//         product: product,
//         addedAt: DateTime.now(),
//       ));
//       state = FavoritesState(favorites: currentFavorites);
//     }
//   }
//
//   void removeFromFavorites(String productId) {
//     final currentFavorites = List<FavoriteItem>.from(state.favorites);
//     currentFavorites.removeWhere((item) => item.product.id == productId);
//     state = FavoritesState(favorites: currentFavorites);
//   }
//
//   void toggleFavorite(Product product) {
//     if (isProductFavorite(product.id)) {
//       removeFromFavorites(product.id);
//     } else {
//       addToFavorites(product);
//     }
//   }
//
//   void clearFavorites() {
//     state = FavoritesState(favorites: []);
//   }
// }
//
// class FavoritesState {
//   final List<FavoriteItem> favorites;
//
//   FavoritesState({required this.favorites});
//
//   int get favoritesCount => favorites.length;
// }
//
// lib/ui/features/favorites/providers/favorite_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/favorite_item.dart';
import '../../../../data/datasources/api/Favorite_api_datasource.dart';
import '../../../../data/datasources/api/favorite_api_datasource.dart' hide FavoriteApiDataSource;
import '../../../../data/datasources/api/product_api_datasource.dart';
import '../../../../data/repositories/favorites_repository_impl.dart';
import '../../../../domain/usecases/favorites/add_to_favorite_usecase.dart';
import '../../../../domain/usecases/favorites/is_product_favorite_usecase.dart';
import '../../../../domain/usecases/favorites/remove_from_favorite_usecase.dart';
import '../../../../domain/usecases/favorites/get_favorites_usecase.dart';

// ========== DEPENDENCY PROVIDERS ==========
final favoriteDataSourceProvider = Provider<FavoriteApiDataSource>((ref) {
  return MockFavoriteApiDataSource();
});

// Note: You need a productDataSourceProvider from your Home feature
// If you don't have it, let me know and I'll help create it
final productDataSourceProvider = Provider<ProductApiDataSource>((ref) {
  // You need to create this or import from home
  throw UnimplementedError('Create productDataSourceProvider first');
});

final favoriteRepositoryProvider = Provider<FavoriteRepositoryImpl>((ref) {
  final favoriteDataSource = ref.watch(favoriteDataSourceProvider);
  final productDataSource = ref.watch(productDataSourceProvider);
  return FavoriteRepositoryImpl(
    favoriteDataSource: favoriteDataSource,
    productDataSource: productDataSource,
  );
});

// Match your use case names exactly
final addToFavoritesUseCaseProvider = Provider<AddToFavoritesUseCase>((ref) {
  final repository = ref.watch(favoriteRepositoryProvider);
  return AddToFavoritesUseCase(repository); // Singular 'Favorite'
});

final removeFromFavoritesUseCaseProvider = Provider<RemoveFromFavoritesUseCase>((ref) {
  final repository = ref.watch(favoriteRepositoryProvider);
  return RemoveFromFavoritesUseCase(repository); // Singular 'Favorite'
});

final getFavoritesUseCaseProvider = Provider<GetFavoritesUseCase>((ref) {
  final repository = ref.watch(favoriteRepositoryProvider);
  return GetFavoritesUseCase(repository);
});

// Match your actual use case name
final checkFavoriteStatusUseCaseProvider = Provider<CheckFavoriteStatusUseCase>((ref) {
  final repository = ref.watch(favoriteRepositoryProvider);
  return CheckFavoriteStatusUseCase(repository); // Changed to match your import
});

// ========== FAVORITE STATE PROVIDER ==========
class FavoriteNotifier extends StateNotifier<FavoriteState> {
  final Ref ref;

  FavoriteNotifier(this.ref) : super(const FavoriteState());

  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true);

    try {
      final useCase = ref.read(getFavoritesUseCaseProvider);
      final favorites = await useCase.execute();

      state = state.copyWith(
        favorites: favorites,
        isLoading: false,
      );
    } catch (error) {
      state = state.copyWith(
        error: error.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> addToFavorites(String productId) async {
    try {
      final useCase = ref.read(addToFavoritesUseCaseProvider);
      final newFavorite = await useCase.execute(productId);

      // Add to local state
      final updatedFavorites = [...state.favorites, newFavorite];
      state = state.copyWith(favorites: updatedFavorites);
    } catch (error) {
      state = state.copyWith(error: error.toString());
      rethrow;
    }
  }

  Future<void> removeFromFavorites(String favoriteId) async {
    try {
      final useCase = ref.read(removeFromFavoritesUseCaseProvider);
      await useCase.execute(favoriteId);

      // Remove from local state
      final updatedFavorites = state.favorites
          .where((fav) => fav.id != favoriteId)
          .toList();
      state = state.copyWith(favorites: updatedFavorites);
    } catch (error) {
      state = state.copyWith(error: error.toString());
      rethrow;
    }
  }

  // Remove product from favorites by product ID
  Future<void> removeFromFavoritesByProductId(String productId) async {
    try {
      // Find the favorite item by product ID
      final favorite = state.favorites.firstWhere(
            (fav) => fav.product.id == productId,
        orElse: () => throw Exception('Favorite not found'),
      );

      await removeFromFavorites(favorite.id);
    } catch (error) {
      state = state.copyWith(error: error.toString());
      rethrow;
    }
  }

  Future<bool> isFavorite(String productId) async {
    try {
      final useCase = ref.read(checkFavoriteStatusUseCaseProvider);
      return await useCase.execute(productId);
    } catch (error) {
      return false;
    }
  }

  // Toggle favorite status
  Future<void> toggleFavorite(String productId) async {
    try {
      final isCurrentlyFavorite = await isFavorite(productId);

      if (isCurrentlyFavorite) {
        await removeFromFavoritesByProductId(productId);
      } else {
        await addToFavorites(productId);
      }
    } catch (error) {
      state = state.copyWith(error: error.toString());
      rethrow;
    }
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }
}

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, FavoriteState>((ref) {
  return FavoriteNotifier(ref)..loadFavorites();
});

// ========== FAVORITE STATE ==========
class FavoriteState {
  final List<FavoriteItem> favorites;
  final bool isLoading;
  final String? error;

  const FavoriteState({
    this.favorites = const [],
    this.isLoading = false,
    this.error,
  });

  int get count => favorites.length;

  FavoriteState copyWith({
    List<FavoriteItem>? favorites,
    bool? isLoading,
    String? error,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}