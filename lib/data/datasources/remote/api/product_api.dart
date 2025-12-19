import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/product_dto.dart';

part 'product_api.g.dart';

@RestApi(baseUrl: 'http://127.0.0.1:8000') // replace with your API URL
abstract class ProductApi {
  factory ProductApi(Dio dio, {String baseUrl}) = _ProductApi;

  @GET('/products')
  Future<List<ProductDto>> getAllProducts();
}
