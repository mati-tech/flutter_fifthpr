// import '../../../../core/models/favorite.dart';
// import '../dto/favorite_dto.dart';
//
// class FavoriteMapper {
//   static Favorite toDomain(FavoriteDto dto) => Favorite(
//     id: dto.id,
//     userId: dto.userId,
//     productId: dto.productId,
//     productName: dto.product.name,
//     productImageUrl: dto.product.imageUrl,
//     productPrice: dto.product.price,
//   );
//
//   static FavoriteDto toDto(Favorite domain) => FavoriteDto(
//     id: domain.id,
//     userId: domain.userId,
//     productId: domain.productId,
//     product: ProductDetailsDto(
//       name: domain.productName,
//       price: domain.productPrice,
//       category: '', // You might need to add this to Favorite model
//       imageUrl: domain.productImageUrl,
//       id: domain.productId,
//     ),
//   );
// }