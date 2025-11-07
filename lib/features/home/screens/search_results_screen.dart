import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/app_theme.dart';
import '../state/home_container.dart';
import '../widgets/product_grid.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_filter.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../core/setup_di.dart';
import '../../../core/widgets/listenable_builder.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerListenableBuilder<HomeContainer>(
      getNotifier: () => getIt<HomeContainer>(),
      builder: (context, homeContainer) {
        return Scaffold(
      appBar: AppBar(
        title: const Text('Search your electronics...'),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {
        //     context.pop();
        //   },
        // ),

        actions: [
          if (homeContainer.searchQuery.isNotEmpty || homeContainer.selectedCategory != 'All')
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () {
                homeContainer.clearFilters();
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
            child: homeContainer.filteredProducts.isEmpty
                ? _buildEmptyState(homeContainer)
                : _buildSearchResults(homeContainer),
          ),
        ],
      ),
        );
      },
    );
  }

  Widget _buildEmptyState(HomeContainer homeContainer) {
    if (homeContainer.searchQuery.isEmpty && homeContainer.selectedCategory == 'All') {
      return const EmptyState(
        title: 'Search Products',
        message: 'Use the search bar above to find products',
        icon: Icons.search,
      );
    } else if (homeContainer.searchQuery.isEmpty) {
      return EmptyState(
        title: 'No Products in ${homeContainer.selectedCategory}',
        message: 'Try selecting a different category',
        icon: Icons.category,
        buttonText: 'Clear Filters',
        onButtonPressed: () {
          homeContainer.clearFilters();
        },
      );
    } else {
      return EmptyState(
        title: 'No Results for "${homeContainer.searchQuery}"',
        message: 'Try adjusting your search or filters',
        icon: Icons.search_off,
        buttonText: 'Clear Search',
        onButtonPressed: () {
          homeContainer.clearFilters();
        },
      );
    }
  }

  Widget _buildSearchResults(HomeContainer homeContainer) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${homeContainer.filteredProducts.length} products found',
                style: TextStyle(
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (homeContainer.searchQuery.isNotEmpty || homeContainer.selectedCategory != 'All')
                TextButton(
                  onPressed: () {
                    homeContainer.clearFilters();
                  },
                  child: const Text('Clear All'),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ProductGrid(products: homeContainer.filteredProducts),
        ),
      ],
    );
  }
}