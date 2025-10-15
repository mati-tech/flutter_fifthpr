
import 'package:fifthpr/features/products/product_card.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';

class ProductsScreen extends StatelessWidget {
  final List<Product> products;
  final Function(Product, int) onAddToCart;
  final VoidCallback onViewCart;
  final int cartItemCount;
  final Function(Product) onViewProductDetails;

  const ProductsScreen({
    required this.products,
    required this.onAddToCart,
    required this.onViewCart,
    required this.cartItemCount,
    required this.onViewProductDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(

          padding: EdgeInsets.all(16),
          color: Colors.blue.shade50,
          child: Row(
            children: [
              Icon(Icons.shop, color: Colors.blue.shade800),
              SizedBox(width: 8),
              Text(
                'Our Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              Spacer(),
              Text(
                '${products.length} items',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        // Products Grid
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.7,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onAddToCart: () => onAddToCart(product, 1),
                onViewDetails: () => onViewProductDetails(product),
              );
            },
          ),
        ),
      ],
    );
  }
}