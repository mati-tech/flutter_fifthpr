import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/app_theme.dart';
import '../providers/home_provider.dart';
import '../widgets/product_grid.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_filter.dart';
import '../../../shared/widgets/empty_state.dart';

class SearchResultsScreen extends ConsumerWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search your electronics...'),
        actions: [
          if (homeState.isSearchActive)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () {
                homeNotifier.clearFilters();
              },
            ),
        ],
      ),
      body: Column(
        children: [
          const SearchBarWidget(autoFocus: true),
          const CategoryFilter(),
          const SizedBox(height: 16),
          // Search Results
          Expanded(
            child: homeState.filteredProducts.isEmpty
                ? _buildEmptyState(homeState, homeNotifier)
                : _buildSearchResults(homeState, homeNotifier),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(HomeState homeState, HomeNotifier homeNotifier) {
    if (homeState.searchQuery.isEmpty && homeState.selectedCategory == 'All') {
      return const EmptyState(
        title: 'Search Products',
        message: 'Use the search bar above to find products',
        icon: Icons.search,
      );
    } else if (homeState.searchQuery.isEmpty) {
      return EmptyState(
        title: 'No Products in ${homeState.selectedCategory}',
        message: 'Try selecting a different category',
        icon: Icons.category,
        buttonText: 'Clear Filters',
        onButtonPressed: () {
          homeNotifier.clearFilters();
        },
      );
    } else {
      return EmptyState(
        title: 'No Results for "${homeState.searchQuery}"',
        message: 'Try adjusting your search or filters',
        icon: Icons.search_off,
        buttonText: 'Clear Search',
        onButtonPressed: () {
          homeNotifier.clearFilters();
        },
      );
    }
  }

  Widget _buildSearchResults(HomeState homeState, HomeNotifier homeNotifier) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${homeState.searchResultsCount} products found',
                style: TextStyle(
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (homeState.isSearchActive)
                TextButton(
                  onPressed: () {
                    homeNotifier.clearFilters();
                  },
                  child: const Text('Clear All'),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ProductGrid(products: homeState.filteredProducts),
        ),
      ],
    );
  }
}