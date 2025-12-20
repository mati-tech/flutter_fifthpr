// lib/presentation/features/cart/widgets/cart_tile.dart
import 'package:flutter/material.dart';
import '../../../../core/models/cart_product.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  const CartTile({super.key, required this.cartProduct});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(cartProduct.thumbnail, width: 50, height: 50),
      title: Text(cartProduct.title),
      subtitle: Text('Qty: ${cartProduct.quantity} | \$${cartProduct.discountedTotal.toStringAsFixed(2)}'),
      trailing: Text('\$${cartProduct.total.toStringAsFixed(2)}'),
    );
  }
}
