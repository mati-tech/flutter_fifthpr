import 'package:flutter/material.dart';

import '../../models/product.dart';


class ProductDetailDialog extends StatelessWidget {
  final Product product;
  final Function(Product, int) onAddToCart;

  const ProductDetailDialog({
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              product.description,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Price: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Stock: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${product.stockQuantity} available',
                  style: TextStyle(
                    color: product.isAvailable ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Close'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: product.isAvailable
                        ? () {
                      onAddToCart(product, 1);
                      Navigator.pop(context);
                    }
                        : null,
                    child: Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}