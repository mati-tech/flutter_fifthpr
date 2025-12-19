// import 'api/favorites_api.dart';
// import 'dto/Favorite_dto.dart';
//
// class FavoritesRemoteDataSource {
//   final FavoritesApi api;
//
//   FavoritesRemoteDataSource(this.api);
//
//   Future<List<FavoriteDto>> getUserFavorites(String userId) =>
//       api.getUserFavorites(userId);
//
//   // Future<FavoriteDto> addFavorite(FavoriteDto favorite) async {
//     // Convert to backend expected format
//     // final body = {
//       // 'user_id': int.tryParse(favorite.userId) ?? 0,
//       // 'product_id': int.tryParse(favorite.productId) ?? 0,
//       // // Backend might auto-create the product object
//     // };
//     // return await api.addFavorite(body);
//   // }
//
//   Future<void> removeFavorite(String userId, String productId) =>
//       api.removeFavorite(userId, productId);
// }