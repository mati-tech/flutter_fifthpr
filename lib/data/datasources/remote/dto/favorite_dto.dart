// import 'package:json_annotation/json_annotation.dart';
//
// part 'favorite_dto.g.dart';
//
// @JsonSerializable()
// class FavoriteDto {
//   @JsonKey(fromJson: _stringFromJson)
//   final String id; // Convert from int to String
//
//   @JsonKey(name: 'user_id', fromJson: _stringFromJson)
//   final String userId;
//
//   @JsonKey(name: 'product_id', fromJson: _stringFromJson)
//   final String productId;
//
//   // Add nested product field
//   @JsonKey(name: 'product')
//   final ProductDetailsDto product;
//
//   FavoriteDto({
//     required this.id,
//     required this.userId,
//     required this.productId,
//     required this.product,
//   });
//
//   factory FavoriteDto.fromJson(Map<String, dynamic> json) =>
//       _$FavoriteDtoFromJson(json);
//
//   Map<String, dynamic> toJson() => _$FavoriteDtoToJson(this);
//
//   // Helper method to convert int/dynamic to String
//   static String _stringFromJson(dynamic value) {
//     return value?.toString() ?? '';
//   }
// }
//
// // Add this new DTO for nested product
// @JsonSerializable()
// class ProductDetailsDto {
//   final String name;
//   final double price;
//   final String category;
//
//   @JsonKey(name: 'image_url')
//   final String imageUrl;
//
//   @JsonKey(fromJson: _stringFromJson)
//   final String id;
//
//   ProductDetailsDto({
//     required this.name,
//     required this.price,
//     required this.category,
//     required this.imageUrl,
//     required this.id,
//   });
//
//   factory ProductDetailsDto.fromJson(Map<String, dynamic> json) =>
//       _$ProductDetailsDtoFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ProductDetailsDtoToJson(this);
//
//   static String _stringFromJson(dynamic value) {
//     return value?.toString() ?? '';
//   }
// }