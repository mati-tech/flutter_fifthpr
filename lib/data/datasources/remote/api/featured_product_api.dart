import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/models/cart.dart';
import '../../../../core/models/user.dart';
import '../dto/cart_dto.dart';
import '../dto/featured_product_dto.dart';
import '../dto/product_detail_dto.dart';
import '../dto/product_dto.dart';
import '../dto/product_response_dto.dart';
import '../dto/user_dto.dart';
// import '../dto/featured_product_dto.dart';


part 'featured_product_api.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com/')
abstract class FeaturedProductApi {
  factory FeaturedProductApi(Dio dio, {String baseUrl}) = _FeaturedProductApi;

  @GET('/products/category/smartphones')
  Future<List<FeaturedProductDto>> getElectronics();

  @GET('/products/category/laptops')
  Future<ProductsResponseDto> getAllProducts();

  @GET('/products/{id}')
  Future<ProductDto> getProductDetail(@Path('id') int id);

  @GET('/products/search')
  Future<ProductsResponseDto> searchProducts(@Query('q') String query);


  @GET("/carts/user/{userId}")
  Future<CartResponseDto> getUserCarts(@Path("userId") int userId);

  @GET('/users/{id}')
  Future<UserDto> getUserDetail(@Path('id') int id);

  @DELETE('/users/{id}')
  Future<UserDto> deleteUser(@Path('id') int userId);

}
