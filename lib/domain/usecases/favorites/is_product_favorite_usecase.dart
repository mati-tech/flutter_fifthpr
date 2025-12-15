// lib/domain/usecases/favorites/check_favorite_status_usecase.dart
import '../../interfaces/repositories/fav_repository.dart';
// import '../../interfaces/repositories/favorite_repository.dart';

class CheckFavoriteStatusUseCase {
  final FavoriteRepository repository;

  CheckFavoriteStatusUseCase(this.repository);

  Future<bool> execute(String productId) async {
    if (productId.isEmpty) {
      return false;
    }

    return await repository.isFavorite(productId);
  }
}