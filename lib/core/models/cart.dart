// cart.dart
import 'cart_product.dart';

class Cart {
  final int id;
  final List<CartProduct> products;
  final double total;
  final double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  Cart({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json['id'],
    products: (json['products'] as List)
        .map((e) => CartProduct.fromJson(e))
        .toList(),
    total: (json['total'] as num).toDouble(),
    discountedTotal: (json['discountedTotal'] as num).toDouble(),
    userId: json['userId'],
    totalProducts: json['totalProducts'],
    totalQuantity: json['totalQuantity'],
  );
}
