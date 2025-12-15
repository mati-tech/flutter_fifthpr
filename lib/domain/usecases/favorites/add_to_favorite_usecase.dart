// lib/domain/usecases/favorites/add_to_favorites_usecase.dart
import '../../../core/models/favorite_item.dart';
import '../../interfaces/repositories/fav_repository.dart';
// import '../../interfaces/repositories/favorite_repository.dart';
// import '../../entities/favorite_item.dart';

class AddToFavoritesUseCase {
  final FavoriteRepository repository;

  AddToFavoritesUseCase(this.repository);

  Future<FavoriteItem> execute(String productId) async {
    if (productId.isEmpty) {
      throw ArgumentError('Product ID cannot be empty');
    }
    return await repository.addToFavorites(productId);
  }
}