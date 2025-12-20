// import 'api/fakestore_api.dart';
import 'api/featured_product_api.dart';
import 'dto/featured_product_dto.dart';
import 'dto/product_detail_dto.dart';
import 'dto/user_dto.dart';
// import 'dto/product_dto.dart';

class FeaturedProductRemoteDataSource {
  final FeaturedProductApi api;

  FeaturedProductRemoteDataSource(this.api);

  Future<List<FeaturedProductDto>> getElectronics() {
    return api.getElectronics();
  }

  Future<List<FeaturedProductDto>> getAllProducts() {
    return api.getAllProducts();
  }

  Future<ProductDetailDto> getProductDetail(int id) {
    return api.getProductDetail(id);
  }

  Future<UserDto> getUserDetail(int id) {
    return api.getUserDetail(id);
  }

  Future<UserDto> deleteUser (int id) {
    return api.deleteUser(id);
  }


}
