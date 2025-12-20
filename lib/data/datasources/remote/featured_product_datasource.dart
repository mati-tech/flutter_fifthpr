// import 'api/fakestore_api.dart';
import '../../../core/models/cart.dart';
import '../../../core/models/cart_product.dart';
import 'api/featured_product_api.dart';
import 'dto/cart_dto.dart';
import 'dto/featured_product_dto.dart';
import 'dto/product_detail_dto.dart';
import 'dto/product_dto.dart';
import 'dto/user_dto.dart';
// import 'dto/product_dto.dart';

class FeaturedProductRemoteDataSource {
  final FeaturedProductApi api;

  FeaturedProductRemoteDataSource(this.api);

  Future<List<FeaturedProductDto>> getElectronics() {
    return api.getElectronics();
  }

  Future<List<ProductDto>> getAllProducts() async {
    final response = await api.getAllProducts();
    return response.products;
  }

  Future<ProductDto> getProductDetail(int id) async {
    return api.getProductDetail(id);
  }

  Future<List<ProductDto>> searchProducts(String query) async {
    final response = await api.searchProducts(query);
    return response.products;
  }


  Future<List<Cart>> getCartByUserId(int userId) async {
    final response = await api.getUserCarts(userId); // returns CartResponseDto

    // Convert List<CartDto> to List<Cart> domain model
    return response.carts.map(_mapCartDtoToDomain).toList();
  }
  Cart _mapCartDtoToDomain(CartDto dto) {
    return Cart(
      id: dto.id,
      products: dto.products.map((p) =>
          CartProduct(
            id: p.id,
            title: p.title,
            price: p.price,
            quantity: p.quantity,
            total: p.total,
            discountPercentage: p.discountPercentage,
            discountedTotal: p.discountedTotal,
            thumbnail: p.thumbnail,
          )).toList(),
      total: dto.total,
      discountedTotal: dto.discountedTotal,
      userId: dto.userId,
      totalProducts: dto.totalProducts,
      totalQuantity: dto.totalQuantity,
    );
    Future<UserDto> getUserDetail(int id) {
      return api.getUserDetail(id);
    }

    Future<UserDto> deleteUser(int id) {
      return api.deleteUser(id);
    }
  }
}

