

import '../../../../core/models/product2.dart';
import '../dto/product2_dto.dart';

extension Product2Mapper on Product2Dto {
  Product2 toDomain() {
    return Product2(
      id: id,
      title: title,
      description: description,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      brand: brand,
      images: images,
    );
  }
}