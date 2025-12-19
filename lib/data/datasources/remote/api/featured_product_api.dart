import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dto/featured_product_dto.dart';
// import '../dto/featured_product_dto.dart';


part 'featured_product_api.g.dart';

@RestApi(baseUrl: 'https://fakestoreapi.com')
abstract class FeaturedProductApi {
  factory FeaturedProductApi(Dio dio, {String baseUrl}) = _FeaturedProductApi;

  @GET('/products/category/electronics')
  Future<List<FeaturedProductDto>> getElectronics();
}
