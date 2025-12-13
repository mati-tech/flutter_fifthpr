class Product {
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

  Product({
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
  });

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  double get discountPercentage {
    if (!hasDiscount) return 0;
    return ((originalPrice! - price) / originalPrice!) * 100;
  }
}