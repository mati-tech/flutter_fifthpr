// import 'package:retrofit/http.dart';
//
// import '../dto/Favorite_dto.dart';
//
// @RestApi(baseUrl: 'http://127.0.0.1:8000/api/favorites')
// abstract class FavoritesApi {
//   factory FavoritesApi(Dio dio, {String baseUrl}) = _FavoritesApi;
//
//   @GET('/user/{user_id}')
//   Future<List<FavoriteDto>> getUserFavorites(@Path() String user_id);
//
//   @POST('/')
//   Future<FavoriteDto> addFavorite(@Body() Map<String, dynamic> body); // Changed!
//
//   @DELETE('/')
//   Future<void> removeFavorite(
//       @Query('user_id') String userId, @Query('product_id') String productId);
// }