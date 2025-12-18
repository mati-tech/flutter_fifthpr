// lib/features/home/screens/product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/cart_item.dart';
import '../../../../core/models/product.dart';
import '../../../shared/tempFavorites.dart';
import '../../../shared/app_theme.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/app_button.dart';
import '../../cart/providers/cart_provider.dart';
import '../../favorites/providers/favorites_provider.dart';
// import '../../favorites/providers/favorite_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get cart state and notifier
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    // Get favorites state and notifier
    final favoritesState = ref.watch(favoriteProvider);
    final favoritesNotifier = ref.read(favoriteProvider.notifier);

    // Check if product is in favorites
    final isFavorite = favoritesState.favorites
        .any((item) => item.product.id == product.id);

    // Get current quantity in cart
    final currentQuantity = _getCurrentQuantity(cartState, product.id);

    // Helper properties
    final bool hasDiscount = product.originalPrice != null &&
        product.originalPrice! > product.price;
    final double? discountPercentage = hasDiscount ?
    ((product.originalPrice! - product.price) / product.originalPrice! * 100) : null;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
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
                  color: isFavorite ? Colors.red : Colors.black,
                ),
                onPressed: () {
                  // Toggle favorite
                  favoritesNotifier.toggleFavorite(product.id);
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
                      child: const Icon(
                        Icons.image,
                        size: 100,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
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
                      if (hasDiscount && discountPercentage != null) ...[
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
                            '${discountPercentage.toStringAsFixed(0)}% OFF',
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
                      if (hasDiscount && product.originalPrice != null) ...[
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

                  // Show current quantity in cart if any
                  if (currentQuantity > 0) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'In cart: $currentQuantity',
                        style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),
                  // Rating and Reviews
                  if (product.rating != null || product.reviewCount != null)
                    Row(
                      children: [
                        if (product.rating != null) ...[
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
                                  product.rating!.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (product.reviewCount != null)
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
                        color: product.stockQuantity > 0
                            ? AppTheme.successColor
                            : AppTheme.errorColor,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        product.stockQuantity > 0
                            ? '${product.stockQuantity} in stock'
                            : 'Out of stock',
                        style: TextStyle(
                          color: product.stockQuantity > 0
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
                  _buildSpecificationItem('Brand', product.brand),
                  if (product.features != null && product.features!.isNotEmpty)
                    ...product.features!.map(
                          (feature) => _buildSpecificationItem('•', feature),
                    ),
                  const SizedBox(height: 80),
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
            // Quantity controls if item is already in cart
            if (currentQuantity > 0) ...[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 20),
                      onPressed: () {
                        // Decrement quantity
                        final cartItem = _findCartItem(cartState, product.id);
                        if (cartItem != null) {
                          cartNotifier.decrementQuantity(cartItem.id);
                        }
                      },
                    ),
                    Text(
                      currentQuantity.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 20),
                      onPressed: () {
                        // Increment quantity
                        final cartItem = _findCartItem(cartState, product.id);
                        if (cartItem != null && cartItem.canIncrease) {
                          cartNotifier.incrementQuantity(cartItem.id);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
            ],

            Expanded(
              child: product.stockQuantity > 0
                  ? AppButton(
                text: currentQuantity > 0 ? 'Update Cart' : 'Add to Cart',
                onPressed: () {
                  if (currentQuantity == 0) {
                    // Add to cart using new Clean Architecture
                    cartNotifier.addToCart(product.id);
                  }
                  _showAddedToCartDialog(context, currentQuantity > 0);
                },
              )
                  : AppButton(
                text: 'Out of Stock',
                onPressed: () {},
                backgroundColor: Colors.grey,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: product.stockQuantity > 0
                  ? AppButton(
                text: 'Buy Now',
                onPressed: () {
                  if (currentQuantity == 0) {
                    cartNotifier.addToCart(product.id);
                  }
                  context.go('/cart');
                },
                backgroundColor: AppTheme.accentColor,
              )
                  : AppButton(
                text: 'Out of Stock',
                onPressed: () {},
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to get current quantity in cart
  int _getCurrentQuantity(CartState cartState, String productId) {
    try {
      final item = cartState.items.firstWhere(
            (item) => item.product.id == productId,
      );
      return item.quantity;
    } catch (e) {
      return 0;
    }
  }

  // Helper to find cart item
  CartItem? _findCartItem(CartState cartState, String productId) {
    try {
      return cartState.items.firstWhere(
            (item) => item.product.id == productId,
      );
    } catch (e) {
      return null;
    }
  }

  Widget _buildSpecificationItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(width: 8),
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

  void _showAddedToCartDialog(BuildContext context, bool isUpdate) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isUpdate
            ? '${product.name} quantity updated!'
            : '${product.name} added to cart!'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            context.go('/cart');
          },
        ),
      ),
    );
  }

  void _shareProduct(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product link copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}