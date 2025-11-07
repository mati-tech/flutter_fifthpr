import 'package:flutter/material.dart';
import '../../../shared/app_theme.dart';
import '../state/cart_container.dart';
import '../widgets/cart_tile.dart';
import '../widgets/cart_summary.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../core/setup_di.dart';
import '../../../core/widgets/listenable_builder.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerListenableBuilder<CartContainer>(
      getNotifier: () => getIt<CartContainer>(),
      builder: (context, cartContainer) {
        return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          if (cartContainer.cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                _showClearConfirmationDialog(context, cartContainer);
              },
            ),
        ],
      ),
      body: cartContainer.cartItems.isEmpty
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
                itemCount: cartContainer.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartContainer.cartItems[index];
                  return CartTile(cartItem: cartItem);
                },
              ),
            ),
            CartSummary(
            totalPrice: cartContainer.totalPrice,
            itemCount: cartContainer.cartItemsCount,
            onCheckout: () {
              _showCheckoutDialog(context, cartContainer);
            },
          ),
        ],
      ),
        );
      },
    );
  }

  void _showClearConfirmationDialog(BuildContext context, CartContainer container) {
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
              container.clearCart();
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

  void _showCheckoutDialog(BuildContext context, CartContainer container) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Placed!'),
        content: Text(
          'Your order for ${container.cartItemsCount} items has been placed successfully!\n\nTotal: \$${container.totalPrice.toStringAsFixed(2)}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              container.clearCart();
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