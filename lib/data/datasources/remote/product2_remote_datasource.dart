

import '../../../core/models/product2.dart';
import 'api/product_api_2.dart';
import 'dto/product2_dto.dart';

class ProductRemote2Datasource {
  final ProductApi2 api;

  ProductRemote2Datasource(this.api);

  Future<List<Product2>> getElectronics() {
    return api.getProductElectronics();
  }

  // Future<List<FeaturedProductDto>> getAllProducts() {
  //   return api.getAllProducts();
  // }
  //
  // Future<ProductDetailDto> getProductDetail(int id) {
  //   return api.getProductDetail(id);
  // }
  //
  // Future<UserDto> getUserDetail(int id) {
  //   return api.getUserDetail(id);
  // }
  //
  // Future<UserDto> deleteUser (int id) {
  //   return api.deleteUser(id);
  // }


}