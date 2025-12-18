// lib/data/dtos/cart_item_dto.dart

class CartItemDto {
  final String id;
  final String productId;
  final int quantity;
  final DateTime addedAt;
  final DateTime? updatedAt;

  CartItemDto({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.addedAt,
    this.updatedAt,
  });

  factory CartItemDto.fromJson(Map<String, dynamic> json) {
    return CartItemDto(
      id: json['id']?.toString() ?? '',
      productId: json['product_id']?.toString() ?? json['productId']?.toString() ?? '',
      quantity: json['quantity'] as int? ?? 1,
      addedAt: DateTime.parse(json['added_at']?.toString() ?? json['addedAt']?.toString() ?? ''),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'].toString())
          : json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'quantity': quantity,
      'added_at': addedAt.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }
}