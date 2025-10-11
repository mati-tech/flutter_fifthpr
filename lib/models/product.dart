class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final int stockQuantity;
  final bool isAvailable;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stockQuantity,
    required this.isAvailable,
  });
}