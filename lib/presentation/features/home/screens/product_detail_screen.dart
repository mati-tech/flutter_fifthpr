// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/models/product.dart';
// import '../../../shared/app_theme.dart';
// import '../../../shared/widgets/app_button.dart';
// import '../../favorites/providers/favorites_provider.dart';
// // import '../providers/favorites_provider.dart';
//
// class ProductDetailScreen extends ConsumerWidget {
//   final Product product;
//
//   const ProductDetailScreen({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     // final favoritesState = ref.watch(favoriteProvider);
//
//     // Convert product.id (int) to String for comparison
//     final productIdString = product.id.toString();
//     // final isFavorite = favoritesState.favorites
//     //     .any((fav) => fav.productId == productIdString);
//
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: screenWidth > 800 ? 400 : 300,
//             pinned: true,
//             floating: true,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.black),
//               onPressed: () => Navigator.pop(context),
//             ),
//             actions: [
//               // Favorite button
//               Consumer(
//                 builder: (context, ref, child) {
//                   // final favoritesState = ref.watch(favoriteProvider);
//                   final productIdString = product.id.toString();
//                   // final isFavorite = favoritesState.favorites
//                       .any((fav) => fav.productId == productIdString);
//
//                   if (favoritesState.isLoading) {
//                     return const Padding(
//                       padding: EdgeInsets.all(12.0),
//                       child: SizedBox(
//                         width: 24,
//                         height: 24,
//                         child: CircularProgressIndicator(strokeWidth: 2),
//                       ),
//                     );
//                   }
//
//                   return IconButton(
//                     icon: Icon(
//                       isFavorite ? Icons.favorite : Icons.favorite_border,
//                       color: isFavorite ? Colors.red : Colors.black,
//                     ),
//                     onPressed: () async {
//                       await _toggleFavorite(context, ref, product);
//                     },
//                   );
//                 },
//               ),
//             ],
//             flexibleSpace: FlexibleSpaceBar(
//               background: Hero(
//                 tag: 'product-image-${product.id}',
//                 child: Image.network(
//                   product.imageUrl,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Container(
//                     color: Colors.grey[200],
//                     child: const Icon(
//                       Icons.image,
//                       size: 100,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: screenWidth > 800 ? 64 : 16,
//                 vertical: 16,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Product Name & Category
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               product.name,
//                               style: const TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 6,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: AppTheme.accentColor.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(16),
//                                 border: Border.all(
//                                   color: AppTheme.accentColor.withOpacity(0.3),
//                                   width: 1,
//                                 ),
//                               ),
//                               child: Text(
//                                 product.category,
//                                 style: TextStyle(
//                                   color: AppTheme.accentColor,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   // Price
//                   Text(
//                     '\$${product.price.toStringAsFixed(2)}',
//                     style: const TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: AppTheme.primaryColor,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                   // Divider before description
//                   Divider(
//                     color: Colors.grey.shade300,
//                     thickness: 1,
//                     height: 40,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomSheet: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border(top: BorderSide(color: Colors.grey.shade200)),
//         ),
//         child: Row(
//           children: [
//             const SizedBox(width: 12),
//             Expanded(
//               child: AppButton(
//                 text: 'Add to Cart',
//                 onPressed: () {
//                   // TODO: Implement add to cart functionality
//                 },
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: AppButton(
//                 text: 'Buy Now',
//                 onPressed: () {
//                   // TODO: Implement buy now functionality
//                 },
//                 backgroundColor: AppTheme.accentColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _toggleFavorite(
//       BuildContext context,
//       WidgetRef ref,
//       Product product,
//       ) async {
//     final favoritesNotifier = ref.read(favoriteProvider.notifier);
//     final favoritesState = ref.read(favoriteProvider);
//
//     // Convert product.id to String
//     final productIdString = product.id.toString();
//     final wasFavorite = favoritesState.favorites
//         .any((fav) => fav.productId == productIdString);
//
//     try {
//       if (wasFavorite) {
//         // Remove from favorites
//         await favoritesNotifier.removeFavorite(productIdString);
//         _showSnackBar(
//           context,
//           'Removed from favorites',
//           action: SnackBarAction(
//             label: 'Undo',
//             onPressed: () async {
//               try {
//                 await favoritesNotifier.addFavorite(
//                   productId: productIdString,
//                   productName: product.name,
//                   productImageUrl: product.imageUrl,
//                   productPrice: product.price,
//                 );
//               } catch (e) {
//                 _showSnackBar(context, 'Failed to undo: $e', isError: true);
//               }
//             },
//           ),
//         );
//       } else {
//         // Add to favorites
//         await favoritesNotifier.addFavorite(
//           productId: productIdString,
//           productName: product.name,
//           productImageUrl: product.imageUrl,
//           productPrice: product.price,
//         );
//         _showSnackBar(context, 'Added to favorites!');
//       }
//     } catch (e) {
//       _showSnackBar(
//         context,
//         'Failed to ${wasFavorite ? 'remove' : 'add'} favorite: $e',
//         isError: true,
//       );
//     }
//   }
//
//   void _showSnackBar(
//       BuildContext context,
//       String message, {
//         SnackBarAction? action,
//         bool isError = false,
//       }) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? Colors.red : null,
//         duration: const Duration(seconds: 2),
//         action: action,
//       ),
//     );
//   }
// }