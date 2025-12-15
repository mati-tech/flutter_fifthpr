/// Local DTO for Product stored in local cache/storage
/// Used for offline access and caching
class ProductLocalDto {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final String category;
  final String brand;
  final double rating;
  final int reviewCount;
  final bool isFeatured;
  final int stock;
  final DateTime? cachedAt; // Timestamp for cache invalidation

  ProductLocalDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.category,
    this.brand = 'Generic',
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isFeatured = false,
    required this.stock,
    this.cachedAt,
  });

  /// Create ProductLocalDto from JSON (for storage)
  factory ProductLocalDto.fromJson(Map<String, dynamic> json) {
    return ProductLocalDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: json['originalPrice'] != null
          ? (json['originalPrice'] as num).toDouble()
          : null,
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      brand: json['brand'] as String? ?? 'Generic',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      isFeatured: json['isFeatured'] as bool? ?? false,
      stock: json['stock'] as int,
      cachedAt: json['cachedAt'] != null
          ? DateTime.parse(json['cachedAt'] as String)
          : null,
    );
  }

  /// Convert ProductLocalDto to JSON (for storage)
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
      'rating': rating,
      'reviewCount': reviewCount,
      'isFeatured': isFeatured,
      'stock': stock,
      if (cachedAt != null) 'cachedAt': cachedAt!.toIso8601String(),
    };
  }

  /// Convert list of ProductLocalDto from JSON list
  static List<ProductLocalDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProductLocalDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

