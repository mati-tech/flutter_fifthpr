// lib/domain/interfaces/repositories/favorite_repository.dart
import '../../../core/models/favorite_item.dart';


abstract class FavoriteRepository {
  // Add product to favorites
  Future<FavoriteItem> addToFavorites(String productId);

  // Remove product from favorites
  Future<void> removeFromFavorites(String favoriteItemId);

  // Remove by product ID
  Future<void> removeFromFavoritesByProductId(String productId);

  // Get all favorite items
  Future<List<FavoriteItem>> getFavorites();

  // Check if product is in favorites
  Future<bool> isFavorite(String productId);

  // Get favorite by ID
  Future<FavoriteItem?> getFavoriteById(String id);

  // Get favorite by product ID
  Future<FavoriteItem?> getFavoriteByProductId(String productId);

  // Clear all favorites
  Future<void> clearFavorites();

  // Get favorites count
  Future<int> getFavoritesCount();
}