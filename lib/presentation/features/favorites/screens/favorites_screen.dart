// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:go_router/go_router.dart';
// // import '../../../../core/models/favorite_item.dart';
// // import '../../../shared/tempFavorites.dart';
// // import '../../../shared/app_theme.dart';
// //
// // import '../providers/favorites_provider.dart';
// // // import '../providers/favorites_provider.g.dart';
// // import '../widgets/favorite_tile.dart';
// // import '../../../shared/widgets/empty_state.dart';
// //
// //
// // class FavoritesScreen extends ConsumerWidget {
// //   FavoritesScreen({super.key});
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final favoritesState = ref.watch(favoriteProvider);
// //     final favoritesNotifier = ref.read(favoriteProvider.notifier);
// //     final tempFavorites = TempFavorites.all; // for the temp fav to show
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('My Favorites'),
// //         actions: [
// //           if (tempFavorites.isNotEmpty)
// //             IconButton(
// //               icon: const Icon(Icons.delete_outline),
// //               onPressed: () {
// //                 TempFavorites.clear();
// //                 // Force rebuild
// //                 Navigator.of(context).pop();
// //                 Navigator.of(context).push(
// //                   MaterialPageRoute(builder: (context) => FavoritesScreen()),
// //                 );
// //               },
// //             ),
// //         ],
// //       ),
// //       body: tempFavorites.isEmpty
// //           ? EmptyState(
// //         title: 'No Favorites',
// //         message: 'Your favorite products will appear here',
// //         icon: Icons.favorite_border,
// //         buttonText: 'Browse Products',
// //         onButtonPressed: () {
// //           context.go('/home');
// //         },
// //       )
// //           : Column(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Row(
// //               children: [
// //                 Text(
// //                   '${tempFavorites.length} items',
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     color: AppTheme.secondaryColor,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Expanded(
// //             child: ListView.builder(
// //               padding: const EdgeInsets.symmetric(horizontal: 16),
// //               itemCount: tempFavorites.length,
// //               itemBuilder: (context, index) {
// //                 final product = tempFavorites[index];
// //                 return FavoriteTile(
// //                   favorite: FavoriteItem(
// //                     product: product,
// //                     addedAt: DateTime.now(), id: product.id,
// //                   ),
// //                   onRemove: () {
// //                     // TempFavorites.remove(product.id);
// //                     // Force rebuild
// //                     Navigator.of(context).pop();
// //                     Navigator.of(context).push(
// //                       MaterialPageRoute(builder: (context) => FavoritesScreen()),
// //                     );
// //                   },
// //                   onTap: () {
// //                     context.push('/product/${product.id}');
// //                   },
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   void _showClearConfirmationDialog(BuildContext context, WidgetRef ref) {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: const Text('Clear All Favorites?'),
// //         content: const Text(
// //             'This will remove all products from your favorites list.'),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: const Text('Cancel'),
// //           ),
// //           TextButton(
// //             onPressed: () {
// //               // ref.read(favoriteProvider.notifier).clearFavorites();
// //               Navigator.pop(context);
// //             },
// //             child: const Text(
// //               'Clear All',
// //               style: TextStyle(color: AppTheme.errorColor),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../core/models/favorite_item.dart';
// import '../../../shared/app_theme.dart';
// import '../providers/favorites_provider.dart';
// import '../widgets/favorite_tile.dart';
// import '../../../shared/widgets/empty_state.dart';
//
// class FavoritesScreen extends ConsumerWidget {
//   FavoritesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final favoritesState = ref.watch(favoriteProvider);
//     final favoritesNotifier = ref.read(favoriteProvider.notifier);
//
//     // Get actual favorites from provider
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
//       body: favoritesState.isLoading
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
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: Icon(
//                       Icons.error_outline,
//                       color: AppTheme.errorColor,
//                       size: 20,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 // Reload favorites
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
//                       // Remove from favorites
//                       await favoritesNotifier.removeFromFavorites(favorite.id);
//
//                       // Show snackbar confirmation
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('${favorite.product.name} removed from favorites'),
//                           duration: const Duration(seconds: 2),
//                           action: SnackBarAction(
//                             label: 'Undo',
//                             onPressed: () async {
//                               // Add back if undo is pressed
//                               await favoritesNotifier.addToFavorites(favorite.product.id);
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                     onTap: () {
//                       context.push('/product/${favorite.product.id}');
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
//   void _showClearConfirmationDialog(BuildContext context, WidgetRef ref) {
//     final favoritesNotifier = ref.read(favoriteProvider.notifier);
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Clear All Favorites?'),
//         content: const Text(
//             'This will remove all products from your favorites list. This action cannot be undone.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context);
//
//               // Get all favorite IDs before clearing
//               final favoritesState = ref.read(favoriteProvider);
//               final favoriteIds = favoritesState.favorites.map((f) => f.id).toList();
//
//               // Clear all favorites one by one
//               for (var favoriteId in favoriteIds) {
//                 await favoritesNotifier.removeFromFavorites(favoriteId);
//               }
//
//               // Show confirmation snackbar
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('All favorites cleared'),
//                   duration: Duration(seconds: 2),
//                 ),
//               );
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