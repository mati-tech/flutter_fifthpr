// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../core/models/favorite.dart';
// import '../../../shared/app_theme.dart';
// import '../providers/favorites_provider.dart';
// import '../widgets/favorite_tile.dart';
// import '../../../shared/widgets/empty_state.dart';
//
// class FavoritesScreen extends ConsumerStatefulWidget {
//   const FavoritesScreen({super.key});
//
//   @override
//   ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
// }
//
// class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Load favorites when screen initializes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(favoriteProvider.notifier).loadFavorites();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final favoritesState = ref.watch(favoriteProvider);
//     final favoritesNotifier = ref.read(favoriteProvider.notifier);
//     final favorites = favoritesState.favorites;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Favorites'),
//         actions: [
//           if (favorites.isNotEmpty)
//             IconButton(
//               icon: const Icon(Icons.delete_outline),
//               onPressed: () => _showClearConfirmationDialog(context, ref),
//             ),
//         ],
//       ),
//       body: favoritesState.isLoading && favorites.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : favorites.isEmpty
//           ? EmptyState(
//         title: 'No Favorites',
//         message: 'Your favorite products will appear here',
//         icon: Icons.favorite_border,
//         buttonText: 'Browse Products',
//         onButtonPressed: () {
//           context.go('/home');
//         },
//       )
//           : Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Text(
//                   '${favorites.length} ${favorites.length == 1 ? 'item' : 'items'}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: AppTheme.secondaryColor,
//                   ),
//                 ),
//                 const Spacer(),
//                 if (favoritesState.error != null)
//                   Tooltip(
//                     message: favoritesState.error!,
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 8.0),
//                       child: Icon(
//                         Icons.error_outline,
//                         color: AppTheme.errorColor,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 await favoritesNotifier.loadFavorites();
//               },
//               child: ListView.builder(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 itemCount: favorites.length,
//                 itemBuilder: (context, index) {
//                   final favorite = favorites[index];
//                   return FavoriteTile(
//                     favorite: favorite,
//                     onRemove: () async {
//                       await _removeFavorite(
//                         context,
//                         ref,
//                         favorite,
//                       );
//                     },
//                     onTap: () {
//                       // Navigate to product detail
//                       context.push('/product/${favorite.productId}');
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _removeFavorite(
//       BuildContext context,
//       WidgetRef ref,
//       Favorite favorite,
//       ) async {
//     final favoritesNotifier = ref.read(favoriteProvider.notifier);
//
//     try {
//       // Store product info for undo
//       final productName = favorite.productName;
//
//       await favoritesNotifier.removeFavorite(favorite.productId);
//
//       // Show snackbar with undo option
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('$productName removed from favorites'),
//           duration: const Duration(seconds: 3),
//           action: SnackBarAction(
//             label: 'Undo',
//             onPressed: () async {
//               try {
//                 await favoritesNotifier.addFavorite(
//                   productId: favorite.productId,
//                   productName: favorite.productName,
//                   productImageUrl: favorite.productImageUrl,
//                   productPrice: favorite.productPrice,
//                 );
//               } catch (e) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Failed to undo: $e'),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to remove: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//   void _showClearConfirmationDialog(BuildContext context, WidgetRef ref) {
//     final favoritesNotifier = ref.read(favoriteProvider.notifier);
//
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
//             onPressed: () async {
//               Navigator.pop(context);
//
//               try {
//                 await favoritesNotifier.clearAllFavorites();
//
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('All favorites cleared'),
//                     duration: Duration(seconds: 2),
//                   ),
//                 );
//               } catch (e) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Failed to clear: $e'),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//               }
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