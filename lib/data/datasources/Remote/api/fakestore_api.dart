import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/fakestore_product_dto.dart';


part 'fakestore_api.g.dart';

@RestApi(baseUrl: 'https://fakestoreapi.com')
abstract class FakeStoreApi {
  factory FakeStoreApi(Dio dio, {String baseUrl}) = _FakeStoreApi;

  /// 5️⃣ Get all products
  @GET('/products')
  Future<List<FakeStoreProductDto>> getProducts();
}
