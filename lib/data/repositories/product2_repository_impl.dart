import 'package:storelytech/core/models/product.dart';
// import 'package:storelytech/data/datasources/remote/featured_product_datasource.dart';
import '../../core/models/featured_product.dart';
import '../../core/models/product2.dart';
import '../../core/models/product_detail.dart';
import '../../core/models/user.dart';
import '../../domain/interfaces/repositories/product2_repository.dart';
import '../../domain/interfaces/repositories/product_repository.dart';
import '../datasources/remote/product2_remote_datasource.dart';
import '../datasources/remote/mappers/product2_mapper.dart';
// import '../datasources/Remote/product_remote_datasource.dart';
// import '../datasources/remote/dto/product_detail_dto.dart';
// import '../datasources/remote/featured_product_datasource.dart';
// import '../datasources/remote/mappers/featured_product_mapper.dart';
// import '../datasources/remote/mappers/product_detail_mapper.dart';
// import '../datasources/remote/mappers/user_mapper.dart';
// import     '../datasources/remote/mappers/product_mapper.dart';


class Product2RepositoryImpl implements Product2Repository {
  final ProductRemote2Datasource productRemote;
  Product2RepositoryImpl(this.productRemote);
  /// Fetch Featured Products (Electronics)
  @override
  Future<List<Product2>> getProducts() async {
    final dtoList = await productRemote.getElectronics();
    return dtoList.map(Product2Mapper.toDomain).toList();
  }

  // @override
  // Future<List<FeaturedProduct>> getProducts() async{
  //   final dtoList = await featuredRemote.getAllProducts();
  //   return dtoList.map(FeaturedProductMapper.toDomain).toList();
  // }
  //
  // @override
  // Future<ProductDetail> getProductDetail(int id) async{
  //   final dto = await featuredRemote.getProductDetail(id);
  //   return ProductDetailMapper.toDomain(dto);
  // }
  //
  // @override
  // Future<User> getUserDetail(int id) async{
  //   final dto = await featuredRemote.getUserDetail(id);
  //   return dto.toDomain(); // Вызываем на экземпляре
  // }
  //
  // @override
  // Future<User> deleteUser(int id) async { // Add 'async'
  //   final dto = await featuredRemote.deleteUser(id);
  //   return dto.toDomain(); // Convert DTO to User
  // }
}
