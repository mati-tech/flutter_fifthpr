import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import '../dto/product2_dto.dart';

part 'product_api_2.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com')
abstract class ProductApi2 {
  factory ProductApi2(Dio dio, {String baseUrl}) = _ProductApi2;

  @GET('/products/category/smartphones')
  Future<List<Product2Dto>> getProductElectronics();

  // @GET('/products')
  // Future<List<FeaturedProductDto>> getAllProducts();
  //
  // @GET('/products/{id}')
  // Future<ProductDetailDto> getProductDetail(@Path('id') int id);
  //
  // @GET('/users/{id}')
  // Future<UserDto> getUserDetail(@Path('id') int id);
  //
  // @DELETE('/users/{id}')
  // Future<UserDto> deleteUser(@Path('id') int userId);

}
