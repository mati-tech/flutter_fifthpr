import 'package:storelytech/core/models/product.dart';
// import 'package:storelytech/data/datasources/remote/featured_product_datasource.dart';
import '../../core/models/featured_product.dart';
import '../../domain/interfaces/repositories/product_repository.dart';
// import '../datasources/Remote/product_remote_datasource.dart';
import '../datasources/remote/featured_product_datasource.dart';
import '../datasources/remote/mappers/featured_product_mapper.dart';
// import     '../datasources/remote/mappers/product_mapper.dart';


class ProductRepositoryImpl implements ProductRepository {
  final FeaturedProductRemoteDataSource featuredRemote;


  ProductRepositoryImpl(this.featuredRemote);

  /// Fetch Featured Products (Electronics)
  @override
  Future<List<FeaturedProduct>> getFeaturedProducts() async {
    final dtoList = await featuredRemote.getElectronics();
    return dtoList.map(FeaturedProductMapper.toDomain).toList();
  }


}
