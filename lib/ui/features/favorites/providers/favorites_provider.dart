import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/models/favorite_item.dart';
import '../../../../core/models/product.dart';
// import '../models/favorite_item.dart';
// import '../../home/models/product.dart';

part 'favorites_provider.g.dart';

@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  @override
  FavoritesState build() {
    return FavoritesState(favorites: []);
  }

  bool isProductFavorite(String productId) {
    return state.favorites.any((item) => item.product.id == productId);
  }

  void addToFavorites(Product product) {
    if (!isProductFavorite(product.id)) {
      final currentFavorites = List<FavoriteItem>.from(state.favorites);
      currentFavorites.add(FavoriteItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        product: product,
        addedAt: DateTime.now(),
      ));
      state = FavoritesState(favorites: currentFavorites);
    }
  }

  void removeFromFavorites(String productId) {
    final currentFavorites = List<FavoriteItem>.from(state.favorites);
    currentFavorites.removeWhere((item) => item.product.id == productId);
    state = FavoritesState(favorites: currentFavorites);
  }

  void toggleFavorite(Product product) {
    if (isProductFavorite(product.id)) {
      removeFromFavorites(product.id);
    } else {
      addToFavorites(product);
    }
  }

  void clearFavorites() {
    state = FavoritesState(favorites: []);
  }
}

class FavoritesState {
  final List<FavoriteItem> favorites;

  FavoritesState({required this.favorites});

  int get favoritesCount => favorites.length;
}

