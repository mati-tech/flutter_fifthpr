// // import '../../data/datasources/remote/favorites_remote_data_source.dart';
// import '../../domain/interfaces/repositories/fav_repository.dart';
// // import '../../domain/interfaces/repositories/favorites_repository.dart';
// import '../../core/models/favorite.dart';
// // import '../datasources/remote/favorite_mapper.dart';
// import '../datasources/remote/favorite_remote_datasource.dart';
// import '../datasources/remote/mappers/favorite_mapper.dart';
//
// class FavoritesRepositoryImpl implements FavoritesRepository {
//   final FavoritesRemoteDataSource remote;
//
//   FavoritesRepositoryImpl(this.remote);
//
//   @override
//   Future<List<Favorite>> getUserFavorites(String userId) async {
//     final dtoList = await remote.getUserFavorites(userId);
//     // return dtoList.map(FavoriteMapper.toDomain).toList();
//   }
//
//   @override
//   Future<void> addFavorite(Favorite favorite) async {
//     final dto = FavoriteMapper.toDto(favorite);
//     // await remote.addFavorite(dto);
//   }
//
//   @override
//   Future<void> removeFavorite(String userId, String productId) async {
//     await remote.removeFavorite(userId, productId);
//   }
// }
