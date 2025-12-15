// lib/data/dtos/favorite_dto.dart

class FavoriteDto {
  final String id;
  final String productId;
  final DateTime addedAt;

  FavoriteDto({
    required this.id,
    required this.productId,
    required this.addedAt,
  });

  factory FavoriteDto.fromJson(Map<String, dynamic> json) {
    return FavoriteDto(
      id: json['id']?.toString() ?? '',
      productId: json['product_id']?.toString() ?? json['productId']?.toString() ?? '',
      addedAt: DateTime.parse(json['added_at']?.toString() ?? json['addedAt']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'added_at': addedAt.toIso8601String(),
    };
  }
}