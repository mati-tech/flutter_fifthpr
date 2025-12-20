// cart_product.dart
class CartProduct {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final double total;
  final double discountPercentage;
  final double discountedTotal;
  final String thumbnail;

  CartProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
    id: json['id'],
    title: json['title'],
    price: (json['price'] as num).toDouble(),
    quantity: json['quantity'],
    total: (json['total'] as num).toDouble(),
    discountPercentage: (json['discountPercentage'] as num).toDouble(),
    discountedTotal: (json['discountedTotal'] as num).toDouble(),
    thumbnail: json['thumbnail'],
  );
}
