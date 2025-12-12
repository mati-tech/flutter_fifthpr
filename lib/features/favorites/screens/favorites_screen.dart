import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/app_theme.dart';
import '../providers/favorites_provider.dart';
import '../widgets/favorite_tile.dart';
import '../../../shared/widgets/empty_state.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesState = ref.watch(favoritesNotifierProvider);
    final favoritesNotifier = ref.read(favoritesNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        actions: [
          if (favoritesState.favorites.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                _showClearConfirmationDialog(context, ref);
              },
            ),
        ],
      ),
      body: favoritesState.favorites.isEmpty
          ? EmptyState(
        title: 'No Favorites',
        message: 'Your favorite products will appear here',
        icon: Icons.favorite_border,
        buttonText: 'Browse Products',
        onButtonPressed: () {
          context.go('/home');
        },
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  '${favoritesState.favoritesCount} items',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.secondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: favoritesState.favorites.length,
              itemBuilder: (context, index) {
                final favorite = favoritesState.favorites[index];
                return FavoriteTile(
                  favorite: favorite,
                  onRemove: () {
                    favoritesNotifier.removeFromFavorites(favorite.product.id);
                  },
                  onTap: () {
                    context.push('/product/${favorite.product.id}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showClearConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Favorites?'),
        content: const Text(
            'This will remove all products from your favorites list.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(favoritesNotifierProvider.notifier).clearFavorites();
              Navigator.pop(context);
            },
            child: const Text(
              'Clear All',
              style: TextStyle(color: AppTheme.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}