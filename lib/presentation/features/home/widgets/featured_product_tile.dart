import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/featured_product.dart';
import '../../../shared/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FeaturedProductTile extends StatelessWidget {
  final FeaturedProduct product;

  const FeaturedProductTile({super.key, required this.product});

  void _navigateToProductDetail(BuildContext context) {
    context.push('/product_detail', extra: product);
  }

  @override
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
                    imageUrl: product.imageUrl,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) =>
                    const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.image,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Product Title
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
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.primaryColor,
                  ),
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
      ),
    );
  }
}
