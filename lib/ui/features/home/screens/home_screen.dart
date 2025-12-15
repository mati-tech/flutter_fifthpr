// // import 'package:flutter/material.dart';
// // import '../models/product.dart';
// // import '../widgets/product_grid.dart';
// // import '../widgets/product_tile.dart';
// //
// // class HomeScreen extends StatefulWidget {
// //   const HomeScreen({super.key});
// //
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   int _selectedIndex = 0;
// //
// //   final List<Product> featuredProducts = [
// //     Product(
// //       id: '1',
// //       name: 'iPhone 14 Pro',
// //       description: 'Latest Apple smartphone with A16 Bionic chip',
// //       price: 999.99,
// //       originalPrice: 1199.99,
// //       imageUrl: 'assets/images/img.png',
// //       category: 'Smartphones',
// //       rating: 4.8,
// //       reviewCount: 234,
// //       stock: 15,
// //     ),
// //     Product(
// //       id: '2',
// //       name: 'Samsung Galaxy S23',
// //       description: 'Powerful Android phone with great camera',
// //       price: 849.99,
// //       imageUrl: 'assets/images/img_2.png',
// //       category: 'Smartphones',
// //       rating: 4.6,
// //       reviewCount: 189,
// //       stock: 10,
// //     ),
// //     Product(
// //       id: '3',
// //       name: 'MacBook Air M2',
// //       description: 'Lightweight laptop with Apple M2 chip',
// //       price: 1199.99,
// //       imageUrl: 'assets/images/img_3.png',
// //       category: 'Laptops',
// //       rating: 4.9,
// //       reviewCount: 156,
// //       stock: 8,
// //     ),
// //     Product(
// //       id: '4',
// //       name: 'Sony WH-1000XM4',
// //       description: 'Noise cancelling wireless headphones',
// //       price: 349.99,
// //       originalPrice: 399.99,
// //       imageUrl: 'assets/images/img_4.png',
// //       category: 'Audio',
// //       rating: 4.7,
// //       reviewCount: 312,
// //       stock: 25,
// //     ),
// //   ];
// //
// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //
// //     switch (index) {
// //       case 0:
// //         break;
// //       case 1:
// //         Navigator.pushNamed(context, '/favorites');
// //         break;
// //       case 2:
// //         Navigator.pushNamed(context, '/cart');
// //         break;
// //       case 3:
// //         Navigator.pushNamed(context, '/settings');
// //         break;
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('StorelyTech'),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.person_outline),
// //             onPressed: () {
// //               Navigator.pushNamed(context, '/profile');
// //             },
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.search),
// //             onPressed: () {},
// //           ),
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Featured Section
// //             const Padding(
// //               padding: EdgeInsets.all(16.0),
// //               child: Text(
// //                 'Featured Products',
// //                 style: TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(
// //               height: 280,
// //               child: ListView.builder(
// //                 scrollDirection: Axis.horizontal,
// //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// //                 itemCount: featuredProducts.length,
// //                 itemBuilder: (context, index) {
// //                   return ProductTile(product: featuredProducts[index]);
// //                 },
// //               ),
// //             ),
// //             const SizedBox(height: 24),
// //             // All Products Section
// //             const Padding(
// //               padding: EdgeInsets.all(16.0),
// //               child: Text(
// //                 'All Products',
// //                 style: TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),
// //             ProductGrid(products: featuredProducts),
// //           ],
// //         ),
// //       ),
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _selectedIndex,
// //         selectedItemColor: Colors.blueAccent,
// //         unselectedItemColor: Colors.grey,
// //         onTap: _onItemTapped,
// //         items: const [
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.home_outlined),
// //             label: 'Home',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.favorite_border),
// //             label: 'Favorites',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.shopping_cart_outlined),
// //             label: 'Basket',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.settings_outlined),
// //             label: 'Settings',
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import '../providers/home_provider.dart';
// import '../widgets/product_grid.dart';
// import '../widgets/product_tile.dart';
// import '../widgets/search_bar.dart';
// import '../widgets/category_filter.dart';
//
// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends ConsumerState<HomeScreen> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//
//     switch (index) {
//       case 0:
//         // Already on home, do nothing
//         break;
//       case 1:
//         context.pushReplacement('/favorites');
//         break;
//       case 2:
//         Navigator.pushNamed(context, '/cart');
//         break;
//       case 3:
//         context.go('/settings');
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final homeState = ref.watch(homeNotifierProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('StorelyTech'),
//         actions: [
//           //profile
//           IconButton(
//             icon: const Icon(Icons.person_outline),
//             onPressed: () {
//               context.pushReplacement('/profile');
//             },
//           ),
//           //search
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               context.pushReplacement('/search');
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Search Bar
//             const SearchBarWidget(),
//
//             // Category Filter
//             const CategoryFilter(),
//
//             // Featured Section
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Text(
//                 'Featured Products',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//
//             SizedBox(
//               height: 280,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 itemCount: homeState.featuredProducts.length,
//                 itemBuilder: (context, index) {
//                   return ProductTile(
//                       product: homeState.featuredProducts[index]);
//                 },
//               ),
//             ),
//             const SizedBox(height: 24),
//
//             // All Products Section
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Text(
//                 'All Products',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             ProductGrid(products: homeState.filteredProducts),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blueAccent,
//         unselectedItemColor: Colors.grey,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite_border),
//             label: 'Favorites',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart_outlined),
//             label: 'Basket',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings_outlined),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/home_provider.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_tile.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_filter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);

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
            const SearchBarWidget(),
            const CategoryFilter(),

            // Featured Section
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
            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: homeState.featuredProducts.length,
                itemBuilder: (context, index) {
                  return ProductTile(
                    product: homeState.featuredProducts[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // All Products Section
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
            ProductGrid(products: homeState.filteredProducts),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // ← Always 0 since this is home screen
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

        break;
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