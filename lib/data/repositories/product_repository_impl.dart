import 'package:storelytech/core/models/product.dart';
// import 'package:storelytech/data/datasources/remote/featured_product_datasource.dart';
import '../../core/models/cart.dart';
import '../../core/models/cart_product.dart';
import '../../core/models/featured_product.dart';
import '../../core/models/product_detail.dart';
import '../../core/models/user.dart';
import '../../domain/interfaces/repositories/product_repository.dart';
// import '../datasources/Remote/product_remote_datasource.dart';
import '../datasources/remote/dto/cart_dto.dart';
import '../datasources/remote/dto/product_detail_dto.dart';
import '../datasources/remote/featured_product_datasource.dart';
import '../datasources/remote/mappers/featured_product_mapper.dart';
import '../datasources/remote/mappers/product_detail_mapper.dart';
import '../datasources/remote/mappers/user_mapper.dart';
// import     '../datasources/remote/mappers/product_mapper.dart';
import '../datasources/remote/mappers/product_mapper.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FeaturedProductRemoteDataSource featuredRemote;
  ProductRepositoryImpl(this.featuredRemote);
  /// Fetch Featured Products (Electronics)
  @override
  Future<List<FeaturedProduct>> getFeaturedProducts() async {
    final dtoList = await featuredRemote.getElectronics();
    return dtoList.map(FeaturedProductMapper.toDomain).toList();
  }

  @override
  Future<List<Product>> getProducts() async{
    final dtoList = await featuredRemote.getAllProducts();
    return dtoList.map(ProductMapper.toDomain).toList();
  }

  @override
  Future<Product> getProductDetail(int id) async{
    final dto = await featuredRemote.getProductDetail(id);
    return ProductMapper.toDomain(dto);
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final dtoList = await featuredRemote.searchProducts(query);
    return dtoList.map(ProductMapper.toDomain).toList();
  }

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
  //
  // @override
  // Future<List<FeaturedProduct>> getProducts() {
  //   // TODO: implement getProducts
  //   throw UnimplementedError();
  // }
  Future<List<Cart>> getCartByUserId(int userId) async {
    final dtoList = await featuredRemote.getCartByUserId(userId);
    return dtoList.map((dto) => _mapCartDtoToDomain(dto as CartDto)).toList();
  }

  Cart _mapCartDtoToDomain(CartDto dto) {
    return Cart(
      id: dto.id,
      products: dto.products
          .map((p) => CartProduct(
        id: p.id,
        title: p.title,
        price: p.price,
        quantity: p.quantity,
        total: p.total,
        discountPercentage: p.discountPercentage,
        discountedTotal: p.discountedTotal,
        thumbnail: p.thumbnail,
      ))
          .toList(),
      total: dto.total,
      discountedTotal: dto.discountedTotal,
      userId: dto.userId,
      totalProducts: dto.totalProducts,
      totalQuantity: dto.totalQuantity,
    );
  }

  @override
  Future<User> deleteUser(int id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<User> getUserDetail(int id) {
    // TODO: implement getUserDetail
    throw UnimplementedError();
  }
}
