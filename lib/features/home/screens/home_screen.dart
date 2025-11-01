// import 'package:flutter/material.dart';
// import '../models/product.dart';
// import '../widgets/product_grid.dart';
// import '../widgets/product_tile.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//
//   final List<Product> featuredProducts = [
//     Product(
//       id: '1',
//       name: 'iPhone 14 Pro',
//       description: 'Latest Apple smartphone with A16 Bionic chip',
//       price: 999.99,
//       originalPrice: 1199.99,
//       imageUrl: 'assets/images/img.png',
//       category: 'Smartphones',
//       rating: 4.8,
//       reviewCount: 234,
//       stock: 15,
//     ),
//     Product(
//       id: '2',
//       name: 'Samsung Galaxy S23',
//       description: 'Powerful Android phone with great camera',
//       price: 849.99,
//       imageUrl: 'assets/images/img_2.png',
//       category: 'Smartphones',
//       rating: 4.6,
//       reviewCount: 189,
//       stock: 10,
//     ),
//     Product(
//       id: '3',
//       name: 'MacBook Air M2',
//       description: 'Lightweight laptop with Apple M2 chip',
//       price: 1199.99,
//       imageUrl: 'assets/images/img_3.png',
//       category: 'Laptops',
//       rating: 4.9,
//       reviewCount: 156,
//       stock: 8,
//     ),
//     Product(
//       id: '4',
//       name: 'Sony WH-1000XM4',
//       description: 'Noise cancelling wireless headphones',
//       price: 349.99,
//       originalPrice: 399.99,
//       imageUrl: 'assets/images/img_4.png',
//       category: 'Audio',
//       rating: 4.7,
//       reviewCount: 312,
//       stock: 25,
//     ),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//
//     switch (index) {
//       case 0:
//         break;
//       case 1:
//         Navigator.pushNamed(context, '/favorites');
//         break;
//       case 2:
//         Navigator.pushNamed(context, '/cart');
//         break;
//       case 3:
//         Navigator.pushNamed(context, '/settings');
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('StorelyTech'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.person_outline),
//             onPressed: () {
//               Navigator.pushNamed(context, '/profile');
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
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
//             SizedBox(
//               height: 280,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 itemCount: featuredProducts.length,
//                 itemBuilder: (context, index) {
//                   return ProductTile(product: featuredProducts[index]);
//                 },
//               ),
//             ),
//             const SizedBox(height: 24),
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
//             ProductGrid(products: featuredProducts),
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
import 'package:provider/provider.dart';
import 'package:storelytech/features/home/screens/search_results_screen.dart';
import '../state/home_container.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_tile.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_filter.dart';
import '../../auth/state/auth_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
      // Already on home, do nothing
        break;
      case 1:
        Navigator.pushNamed(context, '/favorites');
        break;
      case 2:
        Navigator.pushNamed(context, '/cart');
        break;
      case 3:
        Navigator.pushNamed(context, '/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeContainer = Provider.of<HomeContainer>(context);
    final authContainer = Provider.of<AuthContainer>(context);

    return Scaffold(
      // The top part of the app with the profile app button and the search button to search for the products
      appBar: AppBar(
        title: const Text('StorelyTech'),
        actions: [
          //profile
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          //search
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchResultsScreen(),
                ),
              );
            },
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            const SearchBarWidget(),

            // Category Filter
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
                itemCount: homeContainer.featuredProducts.length,
                itemBuilder: (context, index) {
                  return ProductTile(product: homeContainer.featuredProducts[index]);
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
            ProductGrid(products: homeContainer.filteredProducts),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
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
}