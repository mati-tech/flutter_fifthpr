import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../shared/app_theme.dart';
import '../../cart/state/cart_container.dart';
import '../../favorites/state/favorites_container.dart';
import '../models/product.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/app_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartContainer = Provider.of<CartContainer>(context);
    final favoritesContainer = Provider.of<FavoritesContainer>(context);
    final isFavorite = favoritesContainer.isProductFavorite(product.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with back button and actions
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            floating: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                context.pop();
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.black,
                ),
                onPressed: () {
                  favoritesContainer.toggleFavorite(product);
                },
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.black),
                onPressed: () {
                  _shareProduct(context);
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product-image-${product.id}',
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 100, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
          ),
          // Product Details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Price
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (product.hasDiscount) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.accentColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                            style: const TextStyle(
                              color: AppTheme.accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Price Row
                  Row(
                    children: [
                      Text(
                        AppUtils.formatPrice(product.price),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      if (product.hasDiscount) ...[
                        const SizedBox(width: 12),
                        Text(
                          AppUtils.formatPrice(product.originalPrice!),
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppTheme.secondaryColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Rating and Reviews
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber[700],
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              product.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${product.reviewCount} reviews)',
                        style: const TextStyle(
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Stock Status
                  Row(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        color: product.stock > 0
                            ? AppTheme.successColor
                            : AppTheme.errorColor,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        product.stock > 0
                            ? '${product.stock} in stock'
                            : 'Out of stock',
                        style: TextStyle(
                          color: product.stock > 0
                              ? AppTheme.successColor
                              : AppTheme.errorColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Specifications
                  const Text(
                    'Specifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSpecificationItem('Category', product.category),
                  _buildSpecificationItem('Brand', 'Apple'), // You can add brand to Product model
                  _buildSpecificationItem('Model', '2023 Edition'),
                  _buildSpecificationItem('Warranty', '1 Year'),
                  const SizedBox(height: 80), // Space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      // Bottom Add to Cart Button
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          children: [
            // Quantity Selector (Optional - you can add this later)
            Expanded(
              child: product.stock > 0
                  ? AppButton(
                text: 'Add to Cart',
                onPressed: () {
                  cartContainer.addToCart(product);
                  _showAddedToCartDialog(context);
                },
              )
                  : AppButton(
                text: 'Out of Stock',
                onPressed: () {}, // Empty function instead of null
                backgroundColor: Colors.grey, // Visual disabled state
              ),
            ),
            const SizedBox(width: 12),
// Buy Now Button
            Expanded(
              child: product.stock > 0
                  ? AppButton(
                text: 'Buy Now',
                onPressed: () {
                  cartContainer.addToCart(product);
                  Navigator.pushNamed(context, '/cart');
                },
                backgroundColor: AppTheme.accentColor,
              )
                  : AppButton(
                text: 'Out of Stock',
                onPressed: () {}, // Empty function instead of null
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecificationItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppTheme.secondaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddedToCartDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart!'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ),
    );
  }

  void _shareProduct(BuildContext context) {
    // Simple share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product link copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
    // In a real app, you would use the share package:
    // Share.share('Check out ${product.name} on StorelyTech!');
  }
}