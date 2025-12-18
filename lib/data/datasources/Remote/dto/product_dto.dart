
// lib/data/dtos/product_dto.dart
/// DTO that matches the FastAPI Product model:
/// id: int, name: str, price: float, category: str, image_url: str | None
/// We keep a few optional extra fields for existing UI, but they are not
/// required by the backend.
class ProductDto {
  final String id; // stored as String in app, comes as int from backend
  final String name;
  final double price;
  final String category;
  final String? imageUrl;

  // Optional extras used only on the Flutter side
  final String? description;
  final double? originalPrice;
  final String? brand;
  final double? rating;
  final int? reviewCount;
  final bool isFeatured;
  final int? stock;

  ProductDto({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.imageUrl,
    this.description,
    this.originalPrice,
    this.brand,
    this.rating,
    this.reviewCount,
    this.isFeatured = false,
    this.stock,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: json['category']?.toString() ?? '',
      imageUrl: (json['image_url'] ?? json['imageUrl'])?.toString(),
      // Optional extras – backend may not send these
      description: json['description']?.toString(),
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      brand: json['brand']?.toString(),
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'] as int?,
      isFeatured: json['isFeatured'] as bool? ?? false,
      stock: json['stock'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      if (imageUrl != null) 'image_url': imageUrl,
      if (description != null) 'description': description,
      if (originalPrice != null) 'originalPrice': originalPrice,
      if (brand != null) 'brand': brand,
      if (rating != null) 'rating': rating,
      if (reviewCount != null) 'reviewCount': reviewCount,
      'isFeatured': isFeatured,
      if (stock != null) 'stock': stock,
    };
  }
}