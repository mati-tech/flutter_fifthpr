// lib/presentation/features/cart/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/empty_state.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_tile.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          if (!cartState.isEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => ref.read(cartProvider.notifier).loadCartItems(),
            ),
        ],
      ),
      body: cartState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartState.isEmpty
          ? const EmptyState(
        title: 'Your Cart is Empty',
        message: 'Add some products to your cart.',
        icon: Icons.shopping_cart_outlined,
      )
          : ListView.builder(
        itemCount: cartState.items.length,
        itemBuilder: (context, index) {
          final cart = cartState.items[index];
          return Column(
            children: cart.products
                .map(
                  (product) => CartTile(cartProduct: product),
            )
                .toList(),
          );
        },
      ),
    );
  }
}
