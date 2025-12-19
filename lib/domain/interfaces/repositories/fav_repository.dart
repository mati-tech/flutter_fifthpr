import '../../../core/models/favorite.dart';





abstract class FavoritesRepository {
  Future<List<Favorite>> getUserFavorites(String userId);
  Future<void> addFavorite(Favorite favorite);
  Future<void> removeFavorite(String userId, String productId);
}
