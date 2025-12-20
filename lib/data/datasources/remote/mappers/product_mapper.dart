import '../../../../core/models/product.dart';
import '../dto/product_dto.dart';

extension ProductMapper on ProductDto {
  static Product toDomain(ProductDto dto) { // Добавьте static и параметр
    return Product(
      id: dto.id,
      title: dto.title,
      description: dto.description,
      price: dto.price,
      discountPercentage: dto.discountPercentage,
      rating: dto.rating,
      stock: dto.stock,
      brand: dto.brand,
      images: dto.images,
    );
  }
}