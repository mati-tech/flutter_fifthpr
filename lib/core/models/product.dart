// /// Domain entity representing a product
// /// Pure Dart class - no Flutter dependencies
// class Product {
//   final String id;
//   final String name;
//   final String description;
//   final double price;
//   final double? originalPrice;
//   final String imageUrl;
//   final String category;
//   final String brand;
//   final double rating;
//   final int reviewCount;
//   final bool isFeatured;
//   final int stock;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     this.originalPrice,
//     required this.imageUrl,
//     required this.category,
//     this.brand = 'Generic',
//     this.rating = 0.0,
//     this.reviewCount = 0,
//     this.isFeatured = false,
//     required this.stock,
//   });
//
//   bool get hasDiscount => originalPrice != null && originalPrice! > price;
//
//   double get discountPercentage {
//     if (!hasDiscount) return 0;
//     return ((originalPrice! - price) / originalPrice!) * 100;
//   }
//
//   Product copyWith({
//     String? id,
//     String? name,
//     String? description,
//     double? price,
//     double? originalPrice,
//     String? imageUrl,
//     String? category,
//     String? brand,
//     double? rating,
//     int? reviewCount,
//     bool? isFeatured,
//     int? stock,
//   }) {
//     return Product(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       description: description ?? this.description,
//       price: price ?? this.price,
//       originalPrice: originalPrice ?? this.originalPrice,
//       imageUrl: imageUrl ?? this.imageUrl,
//       category: category ?? this.category,
//       brand: brand ?? this.brand,
//       rating: rating ?? this.rating,
//       reviewCount: reviewCount ?? this.reviewCount,
//       isFeatured: isFeatured ?? this.isFeatured,
//       stock: stock ?? this.stock,
//     );
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Product &&
//           runtimeType == other.runtimeType &&
//           id == other.id;
//
//   @override
//   int get hashCode => id.hashCode;
//
//   @override
//   String toString() => 'Product(id: $id, name: $name)';
// }

// lib/domain/entities/product.dart
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice; // Add this
  final String imageUrl;
  final String category; // Changed from categoryId
  final String brand; // Add this
  final double? discount;
  final double? rating;
  final int? reviewCount; // Add this
  final int stockQuantity;
  final List<String>? features;
  final bool isFeatured;
  final DateTime createdAt;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.category,
    required this.brand,
    this.discount,
    this.rating,
    this.reviewCount,
    required this.stockQuantity,
    this.features,
    required this.isFeatured,
    required this.createdAt,
  });

  // Helper getter
  double get discountedPrice {
    if (originalPrice != null && originalPrice! > price) {
      return price;
    }
    return price;
  }

  // Calculate discount percentage
  double? get discountPercentage {
    if (originalPrice != null && originalPrice! > price) {
      return ((originalPrice! - price) / originalPrice! * 100);
    }
    return null;
  }

  // Copy with method
  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    String? imageUrl,
    String? category,
    String? brand,
    double? discount,
    double? rating,
    int? reviewCount,
    int? stockQuantity,
    List<String>? features,
    bool? isFeatured,
    DateTime? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      discount: discount ?? this.discount,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      features: features ?? this.features,
      isFeatured: isFeatured ?? this.isFeatured,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Equality check
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.price == price;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode;
}