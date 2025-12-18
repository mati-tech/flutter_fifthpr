
// lib/data/dtos/product_dto.dart
class ProductDto {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final String category;
  final String brand;
  final double? rating;
  final int? reviewCount;
  final bool isFeatured;
  final int stock;

  ProductDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.category,
    required this.brand,
    this.rating,
    this.reviewCount,
    required this.isFeatured,
    required this.stock,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      imageUrl: json['imageUrl']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      brand: json['brand']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'] as int?,
      isFeatured: json['isFeatured'] as bool? ?? false,
      stock: json['stock'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      if (originalPrice != null) 'originalPrice': originalPrice,
      'imageUrl': imageUrl,
      'category': category,
      'brand': brand,
      if (rating != null) 'rating': rating,
      if (reviewCount != null) 'reviewCount': reviewCount,
      'isFeatured': isFeatured,
      'stock': stock,
    };
  }
}