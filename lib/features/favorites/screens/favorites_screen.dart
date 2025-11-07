import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/app_theme.dart';
import '../state/favorites_container.dart';
import '../widgets/favorite_tile.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../core/setup_di.dart';
import '../../../core/widgets/listenable_builder.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerListenableBuilder<FavoritesContainer>(
      getNotifier: () => getIt<FavoritesContainer>(),
      builder: (context, favoritesContainer) {
        return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        actions: [
          if (favoritesContainer.favorites.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                _showClearConfirmationDialog(context, favoritesContainer);
              },
            ),
        ],
      ),
      body: favoritesContainer.favorites.isEmpty
          ? EmptyState(
        title: 'No Favorites',
        message: 'Your favorite products will appear here',
        icon: Icons.favorite_border,
        buttonText: 'Browse Products',
        onButtonPressed: () {
          // Navigate to home
        },
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  '${favoritesContainer.favoritesCount} items',
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
              itemCount: favoritesContainer.favorites.length,
              itemBuilder: (context, index) {
                final favorite = favoritesContainer.favorites[index];
                return FavoriteTile(
                  favorite: favorite,
                  onRemove: () {
                    favoritesContainer.removeFromFavorites(favorite.product.id);
                  },
                  onTap: () {
                    // Navigate to product detail
                  },
                );
              },
            ),
          ),
        ],
      ),
        );
      },
    );
  }

  void _showClearConfirmationDialog(BuildContext context, FavoritesContainer container) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Favorites?'),
        content: const Text('This will remove all products from your favorites list.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              container.clearFavorites();
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