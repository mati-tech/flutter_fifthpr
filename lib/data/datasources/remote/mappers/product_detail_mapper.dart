import '../../../../core/models/featured_product.dart';
// import '../../domain/models/product.dart';
// import '../datasources/remote/dto/product_dto.dart';
import '../../../../core/models/product_detail.dart';
import '../dto/featured_product_dto.dart';
import '../dto/product_detail_dto.dart';



class ProductDetailMapper {
  static ProductDetail toDomain(ProductDetailDto dto) {
    return ProductDetail(
      id: dto.id,
      title: dto.title,
      price: dto.price,
      description: dto.description,
      imageUrl: dto.image,
    );
  }
}
