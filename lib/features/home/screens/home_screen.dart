import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_tile.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> featuredProducts = [
    Product(
      id: '1',
      name: 'iPhone 14 Pro',
      description: 'Latest Apple smartphone with A16 Bionic chip',
      price: 999.99,
      originalPrice: 1199.99,
      imageUrl: 'https://picsum.photos/200/300?random=1',
      category: 'Smartphones',
      rating: 4.8,
      reviewCount: 234,
      stock: 15,
    ),
    Product(
      id: '2',
      name: 'Samsung Galaxy S23',
      description: 'Powerful Android phone with great camera',
      price: 849.99,
      imageUrl: 'https://picsum.photos/200/300?random=2',
      category: 'Smartphones',
      rating: 4.6,
      reviewCount: 189,
      stock: 10,
    ),
    Product(
      id: '3',
      name: 'MacBook Air M2',
      description: 'Lightweight laptop with Apple M2 chip',
      price: 1199.99,
      imageUrl: 'https://picsum.photos/200/300?random=3',
      category: 'Laptops',
      rating: 4.9,
      reviewCount: 156,
      stock: 8,
    ),
    Product(
      id: '4',
      name: 'Sony WH-1000XM4',
      description: 'Noise cancelling wireless headphones',
      price: 349.99,
      originalPrice: 399.99,
      imageUrl: 'https://picsum.photos/200/300?random=4',
      category: 'Audio',
      rating: 4.7,
      reviewCount: 312,
      stock: 25,
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElectroStore'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                itemCount: featuredProducts.length,
                itemBuilder: (context, index) {
                  return ProductTile(product: featuredProducts[index]);
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
            ProductGrid(products: featuredProducts),
          ],
        ),
      ),
    );
  }
}