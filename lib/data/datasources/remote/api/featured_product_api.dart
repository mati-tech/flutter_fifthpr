import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/models/user.dart';
import '../dto/featured_product_dto.dart';
import '../dto/product_detail_dto.dart';
import '../dto/user_dto.dart';
// import '../dto/featured_product_dto.dart';


part 'featured_product_api.g.dart';

@RestApi(baseUrl: 'https://fakestoreapi.com')
abstract class FeaturedProductApi {
  factory FeaturedProductApi(Dio dio, {String baseUrl}) = _FeaturedProductApi;

  @GET('/products/category/electronics')
  Future<List<FeaturedProductDto>> getElectronics();

  @GET('/products')
  Future<List<FeaturedProductDto>> getAllProducts();

  @GET('/products/{id}')
  Future<ProductDetailDto> getProductDetail(@Path('id') int id);

  @GET('/users/{id}')
  Future<UserDto> getUserDetail(@Path('id') int id);

  @DELETE('/users/{id}')
  Future<UserDto> deleteUser(@Path('id') int userId);

}
