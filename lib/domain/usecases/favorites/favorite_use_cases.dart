


import '../../../core/models/favorite.dart';
import '../../interfaces/repositories/fav_repository.dart';

class GetFavoritesUseCase {
  final FavoritesRepository repository;
  GetFavoritesUseCase(this.repository);

  Future<List<Favorite>> execute(String userId) =>
      repository.getUserFavorites(userId);
}

class AddFavoriteUseCase {
  final FavoritesRepository repository;
  AddFavoriteUseCase(this.repository);

  Future<void> execute(Favorite favorite) => repository.addFavorite(favorite);
}

class RemoveFavoriteUseCase {
  final FavoritesRepository repository;
  RemoveFavoriteUseCase(this.repository);

  Future<void> execute(String userId, String productId) =>
      repository.removeFavorite(userId, productId);
}
