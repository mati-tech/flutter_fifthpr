// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../shared/app_theme.dart';
// import '../providers/favorites_provider.dart';
// import '../widgets/favorite_tile.dart';
// import '../../../shared/widgets/empty_state.dart';
//
// class FavoritesScreen extends ConsumerWidget {
//   const FavoritesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final favoritesState = ref.watch(favoritesNotifierProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Favorites'),
//         actions: [
//           if (favoritesState.favorites.isNotEmpty)
//             IconButton(
//               icon: const Icon(Icons.delete_outline),
//               onPressed: () {
//                 _showClearConfirmationDialog(context, ref);
//               },
//             ),
//         ],
//       ),
//       body: favoritesState.favorites.isEmpty
//           ? EmptyState(
//               title: 'No Favorites',
//               message: 'Your favorite products will appear here',
//               icon: Icons.favorite_border,
//               buttonText: 'Browse Products',
//               onButtonPressed: () {
//                 // Navigate to home
//               },
//             )
//           : Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     children: [
//                       Text(
//                         '${favoritesState.favoritesCount} items',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: AppTheme.secondaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     itemCount: favoritesState.favorites.length,
//                     itemBuilder: (context, index) {
//                       final favorite = favoritesState.favorites[index];
//                       return FavoriteTile(
//                         favorite: favorite,
//                         onRemove: () {
//                           ref
//                               .read(favoritesNotifierProvider.notifier)
//                               .removeFromFavorites(favorite.product.id);
//                         },
//                         onTap: () {
//                           // Navigate to product detail
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
//
//   void _showClearConfirmationDialog(BuildContext context, WidgetRef ref) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Clear All Favorites?'),
//         content: const Text(
//             'This will remove all products from your favorites list.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               ref.read(favoritesNotifierProvider.notifier).clearFavorites();
//               Navigator.pop(context);
//             },
//             child: const Text(
//               'Clear All',
//               style: TextStyle(color: AppTheme.errorColor),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/app_theme.dart';
import '../../cart/providers/cart_provider.dart';
import '../../home/models/product.dart';

import '../../../shared/utils.dart';
import '../../../shared/widgets/app_button.dart';

import '../providers/favorites_provider.dart'; // ← Импортируем FavoritesNotifier

class ProductDetailScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Получаем состояние избранного
    final isFavorite = ref.watch(favoritesNotifierProvider).contains(product.id);

    // Получаем CartNotifier для вызова методов
    final cartNotifier = ref.read(cartNotifierProvider.notifier);

    // Получаем состояние корзины для проверки количества
    final cartState = ref.watch(cartNotifierProvider);
    final currentQuantity = _getCurrentQuantity(cartState, product.id);

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
                  ref.read(favoritesNotifierProvider.notifier).toggleFavorite(product);
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

                  // Показываем текущее количество в корзине
                  if (currentQuantity > 0) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    const SizedBox(height: 16),
                  ],

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
                  _buildSpecificationItem('Brand', product.brand),
                  _buildSpecificationItem('Model', '2023 Edition'),
                  _buildSpecificationItem('Warranty', '1 Year'),
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
            // Quantity controls если товар уже в корзине
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
                        cartNotifier.decrementQuantity(product.id);
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
                        cartNotifier.incrementQuantity(product.id);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
            ],

            Expanded(
              child: product.stock > 0
                  ? AppButton(
                text: currentQuantity > 0 ? 'Update Cart' : 'Add to Cart',
                onPressed: () {
                  if (currentQuantity == 0) {
                    cartNotifier.addToCart(product);
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
              child: product.stock > 0
                  ? AppButton(
                text: 'Buy Now',
                onPressed: () {
                  if (currentQuantity == 0) {
                    cartNotifier.addToCart(product);
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

  // Вспомогательный метод для получения текущего количества
  int _getCurrentQuantity(CartState cartState, String productId) {
    try {
      final item = cartState.cartItems.firstWhere(
            (item) => item.product.id == productId,
      );
      return item.quantity;
    } catch (e) {
      return 0;
    }
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