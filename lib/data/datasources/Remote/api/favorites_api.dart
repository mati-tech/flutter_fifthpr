import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/favorite_dto.dart';
// import 'dto/favorite_dto.dart';

part 'favorites_api.g.dart';

@RestApi(baseUrl: 'http://127.0.0.1:8000')
abstract class FavoritesApi {
  factory FavoritesApi(Dio dio, {String baseUrl}) = _FavoritesApi;

  /// 4️⃣ Add to favorites (JWT protected)
  @POST('/api/favorites/')
  Future<FavoriteDto> addFavorite(
      @Body() Map<String, dynamic> body,
      );
}
