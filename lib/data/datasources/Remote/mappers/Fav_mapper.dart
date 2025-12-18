// lib/data/mappers/favorite_mapper.dart
import '../../../../core/models/favorite_item.dart';
import '../../../../core/models/product.dart';
// import '../../domain/entities/favorite_item.dart';
// import '../../domain/entities/product.dart'; // We'll need to get product details
import '../dto/Favorite_dto.dart';
// import '../dtos/favorite_dto.dart';

class FavoriteMapper {
  // Note: This mapper needs product details from somewhere
  // In real app, you'd fetch product details separately or join data

  static FavoriteItem toDomain(
      FavoriteDto dto,
      Product product, // Need to pass product separately
      ) {
    return FavoriteItem(
      id: dto.id,
      product: product,
      addedAt: dto.addedAt,
    );
  }

  static FavoriteDto toDto(FavoriteItem favorite) {
    return FavoriteDto(
      id: favorite.id,
      productId: favorite.product.id,
      addedAt: favorite.addedAt,
    );
  }
}