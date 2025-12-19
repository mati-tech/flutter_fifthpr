// import 'api/fakestore_api.dart';
import 'api/featured_product_api.dart';
import 'dto/featured_product_dto.dart';
// import 'dto/product_dto.dart';

class FeaturedProductRemoteDataSource {
  final FeaturedProductApi api;

  FeaturedProductRemoteDataSource(this.api);

  Future<List<FeaturedProductDto>> getElectronics() {
    return api.getElectronics();
  }
}
