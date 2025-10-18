import 'package:flutter/material.dart';
import '../models/favorite_item.dart';
import '../../home/models/product.dart';

class FavoritesContainer extends ChangeNotifier {
  final List<FavoriteItem> _favorites = [];

  List<FavoriteItem> get favorites => _favorites;
  int get favoritesCount => _favorites.length;

  bool isProductFavorite(String productId) {
    return _favorites.any((item) => item.product.id == productId);
  }

  void addToFavorites(Product product) {
    if (!isProductFavorite(product.id)) {
      _favorites.add(FavoriteItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        product: product,
        addedAt: DateTime.now(),
      ));
      notifyListeners();
    }
  }

  void removeFromFavorites(String productId) {
    _favorites.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    if (isProductFavorite(product.id)) {
      removeFromFavorites(product.id);
    } else {
      addToFavorites(product);
    }
  }

  void clearFavorites() {
    _favorites.clear();
    notifyListeners();
  }
}