import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/app_theme.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_tile.dart';
import '../widgets/cart_summary.dart';
import '../../../shared/widgets/empty_state.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    // final cartNotifier = ref.read(cartNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          if (cartState.cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                _showClearConfirmationDialog(context, ref);
              },
            ),
        ],
      ),
      body: cartState.cartItems.isEmpty
          ? EmptyState(
              title: 'Your Cart is Empty',
              message: 'Add some products to your cart to see them here',
              icon: Icons.shopping_cart_outlined,
              buttonText: 'Browse Products',
              onButtonPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartState.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartState.cartItems[index];
                      return CartTile(cartItem: cartItem);
                    },
                  ),
                ),
                CartSummary(
                  totalPrice: cartState.totalPrice,
                  itemCount: cartState.cartItemsCount,
                  onCheckout: () {
                    _showCheckoutDialog(context, ref);
                  },
                ),
              ],
            ),
    );
  }

  void _showClearConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cart?'),
        content: const Text('This will remove all items from your cart.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(cartNotifierProvider.notifier).clearCart();
              Navigator.pop(context);
            },
            child: Text(
              'Clear All',
              style: TextStyle(color: AppTheme.errorColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context, WidgetRef ref) {
    final cartState = ref.read(cartNotifierProvider);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Placed!'),
        content: Text(
          'Your order for ${cartState.cartItemsCount} items has been placed successfully!\n\nTotal: \$${cartState.totalPrice.toStringAsFixed(2)}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(cartNotifierProvider.notifier).clearCart();
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/orders');
            },
            child: const Text('View Orders'),
          ),
        ],
      ),
    );
  }
}