import 'api/product_api.dart';
import 'dto/product_dto.dart';


class ProductRemoteDataSource {
  final ProductApi api;

  ProductRemoteDataSource(this.api);

  Future<List<ProductDto>> getAllProducts() {
    return api.getAllProducts();
  }
}
