import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/home_provider.dart';
import '../widgets/featured_product_tile.dart';
import '../widgets/product_grid.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_filter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);

    // // Loading state
    // if (homeState.isLoading) {
    //   return const Scaffold(
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }
    //
    // // Error state
    // if (homeState.error != null) {
    //   return Scaffold(
    //     body: Center(
    //       child: Text(
    //         homeState.error!,
    //         style: const TextStyle(color: Colors.red),
    //       ),
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('StorelyTech'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push('/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SearchBarWidget(),
            // const CategoryFilter(),

            // Featured Products Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Featured Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // SizedBox(
            //   height: 280,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     padding: const EdgeInsets.symmetric(horizontal: 16),
            //     itemCount: homeState.featuredProducts.length,
            //     itemBuilder: (context, index) {
            //       final product = homeState.featuredProducts[index];
            //       return FeaturedProductTile(product: product);
            //     },
            //   ),
            // ),
            const SizedBox(height: 24),

            // General Products Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'All Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ProductGrid(products: homeState.products),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Home
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Basket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        break; // Already Home
      case 1:
        context.pushReplacement('/favorites');
        break;
      case 2:
        context.pushReplacement('/cart');
        break;
      case 3:
        context.pushReplacement('/settings');
        break;
    }
  }
}
