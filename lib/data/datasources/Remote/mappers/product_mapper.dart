import '../../../../core/models/product.dart';
import '../dto/product_dto.dart';

/// Mapper for converting between ProductDto and Product entity
/// Handles the conversion between data layer DTOs and domain entities
// class ProductMapper {
//   /// Convert ProductDto to Product domain entity
//   static Product toDomain(ProductDto dto) {
//     return Product(
//       id: dto.id,
//       name: dto.name,
//       description: dto.description,
//       price: dto.price,
//       originalPrice: dto.originalPrice,
//       imageUrl: dto.imageUrl,
//       category: dto.category,
//       brand: dto.brand,
//       rating: dto.rating,
//       reviewCount: dto.reviewCount,
//       isFeatured: dto.isFeatured,
//       stock: dto.stock, stockQuantitocknull, createdAt: null,
//     );
//   }
//
//   /// Convert Product domain entity to ProductDto
//   static ProductDto toDto(Product product) {
//     return ProductDto(
//       id: product.id,
//       name: product.name,
//       description: product.description,
//       price: product.price,
//       originalPrice: product.originalPrice,
//       imageUrl: product.imageUrl,
//       category: product.category,
//       brand: product.brand,
//       rating: product.rating,
//       reviewCount: product.reviewCount,
//       isFeatured: product.isFeatured,
//       stock: product.stock,
//     );
//   }
//
//   /// Convert list of ProductDto to list of Product entities
//   static List<Product> toDomainList(List<ProductDto> dtos) {
//     return dtos.map((dto) => toDomain(dto)).toList();
//   }
//
//   /// Convert list of Product entities to list of ProductDto
//   static List<ProductDto> toDtoList(List<Product> products) {
//     return products.map((product) => toDto(product)).toList();
//   }
// }


// lib/data/mappers/product_mapper.dart
// import '../../domain/entities/product.dart';
// import '../dtos/product_dto.dart';

class ProductMapper {
  /// Convert ProductDto to Product domain entity
  static Product toDomain(ProductDto dto) {
    return Product(
      id: dto.id,
      name: dto.name,
      description: dto.description ?? '',
      price: dto.price,
      originalPrice: dto.originalPrice,
      imageUrl: dto.imageUrl ?? '',
      category: dto.category,
      brand: dto.brand ?? '',
      rating: dto.rating,
      reviewCount: dto.reviewCount,
      stockQuantity: dto.stock ?? 0, // Map stock → stockQuantity
      features: null, // DTO doesn't have features
      isFeatured: dto.isFeatured,
      createdAt: DateTime.now(), // Use current time or parse from DTO if available
    );
  }

  /// Convert Product domain entity to ProductDto
  static ProductDto toDto(Product product) {
    return ProductDto(
      id: product.id,
      name: product.name,
      price: product.price,
      originalPrice: product.originalPrice,
      imageUrl: product.imageUrl,
      category: product.category,
      description: product.description,
      brand: product.brand,
      rating: product.rating,
      reviewCount: product.reviewCount,
      isFeatured: product.isFeatured,
      stock: product.stockQuantity, // Map stockQuantity → stock
    );
  }

  /// Convert list of ProductDto to list of Product entities
  static List<Product> toDomainList(List<ProductDto> dtos) {
    return dtos.map((dto) => toDomain(dto)).toList();
  }

  /// Convert list of Product entities to list of ProductDto
  static List<ProductDto> toDtoList(List<Product> products) {
    return products.map((product) => toDto(product)).toList();
  }
}
