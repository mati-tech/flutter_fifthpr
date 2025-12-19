import 'package:storelytech/core/models/product.dart';

import '../../core/models/featured_product.dart';
import '../../domain/interfaces/repositories/product_repository.dart';
// import '../../domain/models/product.dart';
// import '../../domain/repositories/product_repository.dart';
import '../datasources/Remote/featured_product_datasource.dart';
import '../datasources/Remote/mappers/featured_product_mapper.dart';
// import '../datasources/remote/product_remote_datasource.dart';
// import '../mappers/product_mapper.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FeaturedProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<FeaturedProduct>> getFeaturedProducts() async {
    final dtoList = await remoteDataSource.getElectronics();
    return dtoList
        .map(FeaturedProductMapper.toDomain)
        .toList();
  }

  @override
  Future<List<Product>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

}
