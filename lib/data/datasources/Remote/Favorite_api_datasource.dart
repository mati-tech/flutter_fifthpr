// // lib/data/datasources/Remote/favorite_api_datasource.dart
//
// import 'package:dio/dio.dart';
// import '../../../core/network/api_client_provider.dart';
//
// abstract class FavoriteApiDataSource {
//   // Add to favorites
//   Future<Map<String, dynamic>> addToFavorites(String productId);
//
//   // Remove from favorites
//   Future<void> removeFromFavorites(String favoriteId);
//
//   // Get all favorites
//   Future<List<Map<String, dynamic>>> getFavorites();
//
//   // Check if product is favorite
//   Future<bool> isFavorite(String productId);
//
//   // Clear all favorites
//   Future<void> clearFavorites();
//
//   // Get favorite by ID
//   Future<Map<String, dynamic>> getFavoriteById(String id);
// }
//
// // lib/data/datasources/mock_favorite_api_datasource.dart
// // import 'favorite_api_datasource.dart';
//
// /// FastAPI-backed implementation using Dio
// class FastApiFavoriteApiDataSource implements FavoriteApiDataSource {
//   final ApiClient _client;
//
//   FastApiFavoriteApiDataSource(this._client);
//
//   Dio get _dio => _client.dio;
//
//   @override
//   Future<Map<String, dynamic>> addToFavorites(String productId) async {
//     // NOTE: Backend expects user_id; in a real app, derive it from /auth/me
//     // Here we assume backend uses current user from token and ignores user_id
//     final response = await _dio.post(
//       '/Remote/favorites/',
//       data: {
//         'product_id': int.tryParse(productId) ?? productId,
//       },
//     );
//     return response.data as Map<String, dynamic>;
//   }
//
//   @override
//   Future<void> removeFromFavorites(String favoriteId) async {
//     await _dio.delete('/Remote/favorites/$favoriteId');
//   }
//
//   @override
//   Future<List<Map<String, dynamic>>> getFavorites() async {
//     // In FastAPI spec we have: GET /Remote/favorites/user/{user_id}
//     // Here we assume backend exposes /Remote/favorites/ for current user token
//     final response = await _dio.get('/Remote/favorites/');
//     final data = response.data as List<dynamic>;
//     return data.cast<Map<String, dynamic>>();
//   }
//
//   @override
//   Future<bool> isFavorite(String productId) async {
//     final favorites = await getFavorites();
//     return favorites.any(
//       (fav) => fav['product_id']?.toString() == productId,
//     );
//   }
//
//   @override
//   Future<void> clearFavorites() async {
//     await _dio.delete('/Remote/favorites/');
//   }
//
//   @override
//   Future<Map<String, dynamic>> getFavoriteById(String id) async {
//     final response = await _dio.get('/Remote/favorites/$id');
//     return response.data as Map<String, dynamic>;
//   }
// }
