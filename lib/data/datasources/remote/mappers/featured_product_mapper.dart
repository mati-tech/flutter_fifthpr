import '../../../../core/models/featured_product.dart';
// import '../../domain/models/product.dart';
// import '../datasources/remote/dto/product_dto.dart';
import '../dto/featured_product_dto.dart';

class FeaturedProductMapper {
  static FeaturedProduct toDomain(FeaturedProductDto dto) {
    return FeaturedProduct(
      id: dto.id,
      title: dto.title,
      price: dto.price,
      imageUrl: dto.image,
    );
  }
}
