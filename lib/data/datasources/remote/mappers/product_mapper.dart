import '../../../../core/models/product.dart';
import '../dto/product_dto.dart';

class ProductMapper {
  static Product toDomain(ProductDto dto) {
    return Product(
      id: dto.id,
      name: dto.name,
      price: dto.price,
      category: dto.category,
      imageUrl: dto.imageUrl,
    );
  }
}
