import '../../../core/models/favorite_item.dart';
import '../../interfaces/repositories/fav_repository.dart';

class GetFavoritesUseCase {
  final FavoriteRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<List<FavoriteItem>> execute() async {
    return await repository.getFavorites();
  }
}