// lib/data/dtos/favorite_dto.dart
/// DTO that matches the FastAPI Favorite model:
/// id: int, user_id: int, product_id: int
/// In many responses, the related product is also included.

class FavoriteDto {
  final String id; // stored as String, backend sends int
  final String userId;
  final String productId;
  final Map<String, dynamic>? product; // optional embedded product

  FavoriteDto({
    required this.id,
    required this.userId,
    required this.productId,
    this.product,
  });

  factory FavoriteDto.fromJson(Map<String, dynamic> json) {
    return FavoriteDto(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      productId: json['product_id']?.toString() ?? '',
      product: json['product'] is Map<String, dynamic>
          ? (json['product'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      if (product != null) 'product': product,
    };
  }
}