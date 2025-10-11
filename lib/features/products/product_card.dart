import 'package:flutter/material.dart';

import '../../models/product.dart';


class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback onViewDetails;

  const ProductCard({
    required this.product,
    required this.onAddToCart,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Product Image (placeholder)
          Container(
            height: 120,
            color: Colors.grey.shade200,
            child: Icon(
              Icons.shopping_bag,
              size: 50,
              color: Colors.grey.shade400,
            ),
          ),
          // Product Info
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      product.isAvailable ? Icons.check_circle : Icons.cancel,
                      color: product.isAvailable ? Colors.green : Colors.red,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      product.isAvailable ? 'In Stock' : 'Out of Stock',
                      style: TextStyle(
                        fontSize: 12,
                        color: product.isAvailable ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          // Action Buttons
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: product.isAvailable ? onAddToCart : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.info_outline, size: 20),
                  onPressed: onViewDetails,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}