import 'package:flutter/material.dart';
import '../../../../core/models/featured_product.dart';
import '../../../../core/models/product.dart';
import '../../../../core/models/product_detail.dart';
import 'product_tile.dart';

class ProductGrid extends StatelessWidget {
  final List<FeaturedProduct> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine number of columns based on width
    int crossAxisCount;
    if (screenWidth >= 1200) {
      crossAxisCount = 5;
    } else if (screenWidth >= 992) {
      crossAxisCount = 4;
    } else if (screenWidth >= 768) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 2; // default for mobile
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductTile(product: products[index]);
      },
    );
  }
}
