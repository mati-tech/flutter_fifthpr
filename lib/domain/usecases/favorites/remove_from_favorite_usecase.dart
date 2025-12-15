// lib/domain/usecases/favorites/remove_from_favorites_usecase.dart
import '../../interfaces/repositories/fav_repository.dart';
// import '../../interfaces/repositories/favorite_repository.dart';

class RemoveFromFavoritesUseCase {
  final FavoriteRepository repository;

  RemoveFromFavoritesUseCase(this.repository);

  Future<void> execute(String favoriteItemId) async {
    if (favoriteItemId.isEmpty) {
      throw ArgumentError('Favorite item ID cannot be empty');
    }

    await repository.removeFromFavorites(favoriteItemId);
  }
}