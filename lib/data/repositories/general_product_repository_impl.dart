import 'package:storelytech/core/models/product.dart';
import '../../core/models/featured_product.dart';
import '../../domain/interfaces/repositories/general_product_repository.dart';
import '../../domain/interfaces/repositories/product_repository.dart';
import '../datasources/remote/product_api_datasource.dart';
import '../datasources/remote/featured_product_datasource.dart';
import '../datasources/remote/mappers/product_mapper.dart';



class GeneralProductRepositoryImpl implements GeneralProductRepository {
  final ProductRemoteDataSource productRemote;

  GeneralProductRepositoryImpl(this.productRemote);

  @override
  Future<List<Product>> getProducts() async {
    final dtoList = await productRemote.getAllProducts();
    return dtoList.map(ProductMapper.toDomain).toList();
  }
}
