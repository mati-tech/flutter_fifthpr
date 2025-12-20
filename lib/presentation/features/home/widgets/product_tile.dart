import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/featured_product.dart';
import '../../../../core/models/product.dart';
import '../../../../core/models/product_detail.dart';
import '../../../shared/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../screens/product_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ProductTile extends StatelessWidget {
  final Product product;

  void _navigateToProductDetail(BuildContext context) {
    context.push('/product_detail', extra: product.id);
  }

  const ProductTile({super.key, required this.product});

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToProductDetail(context),
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.images[0],
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) =>
                    const CircularProgressIndicator(),
                    errorWidget: (context, url, error) {
                      print("Error loading image: $error"); // console
                      print("URL: $url");
                      return Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.red, // red to see better
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                // Product Name
                Text(
                  product.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Price
                Row(
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    // if (product.hasDiscount) ...[
                    //   const SizedBox(width: 8),
                    //   Text(
                    //     '\$${product.originalPrice!.toStringAsFixed(2)}',
                    //     style: const TextStyle(
                    //       fontSize: 14,
                    //       color: AppTheme.secondaryColor,
                    //       decoration: TextDecoration.lineThrough,
                    //     ),
                    //   ),
                    // ],
                  ],
                ),
                const SizedBox(height: 4),
                // Rating
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber[600],
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    // Text(
                    //   product.rating.toStringAsFixed(1),
                    //   style: const TextStyle(fontSize: 12),
                    // ),
                    const SizedBox(width: 4),
                  ],
                ),
                const Spacer(),
                // Add to Cart Button
                AppButton(
                  text: 'Add to Cart',
                  onPressed: () {},
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ),
      )
    );


  }
}