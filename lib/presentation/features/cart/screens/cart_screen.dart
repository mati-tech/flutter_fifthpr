// lib/presentation/features/cart/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/app_theme.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_tile.dart';
import '../widgets/cart_summary.dart'; // Your existing widget
import '../../../shared/widgets/empty_state.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          if (cartState.hasItems)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                _showClearConfirmationDialog(context, ref);
              },
              tooltip: 'Clear Cart',
            ),
        ],
      ),
      body: cartState.isCartLoading
          ? const Center(child: CircularProgressIndicator())
          : cartState.isEmpty
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
              itemCount: cartState.items.length,
              itemBuilder: (context, index) {
                final cartItem = cartState.items[index];
                return CartTile(
                  cartItem: cartItem,
                  onIncrement: () {
                    ref.read(cartProvider.notifier).incrementQuantity(cartItem.id);
                  },
                  onDecrement: () {
                    ref.read(cartProvider.notifier).decrementQuantity(cartItem.id);
                  },
                  onRemove: () {
                    ref.read(cartProvider.notifier).removeFromCart(cartItem.id);
                  },
                );
              },
            ),
          ),
          // Your existing CartSummary widget with updated data
          CartSummary(
            totalPrice: cartState.grandTotal, // Use grandTotal (total - discount)
            itemCount: cartState.totalQuantity, // Use totalQuantity (sum of all quantities)
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
              ref.read(cartProvider.notifier).clearCart();
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
    final cartState = ref.read(cartProvider);

    // Show detailed order summary
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Summary'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Items summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Items (${cartState.totalItems})',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text('\$${cartState.subtotal.toStringAsFixed(2)}'),
                ],
              ),

              // Tax
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tax (8%):'),
                  Text('\$${cartState.tax.toStringAsFixed(2)}'),
                ],
              ),

              // Shipping
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Shipping:'),
                  Text('\$${cartState.shipping.toStringAsFixed(2)}'),
                ],
              ),

              // Discount if applied
              if (cartState.hasDiscount) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount (${cartState.couponCode}):'),
                    Text(
                      '-\$${cartState.discount.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ],

              const Divider(),

              // Grand Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Grand Total:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '\$${cartState.grandTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Order confirmation message
              const Text(
                'Your order will be processed immediately. You will receive an email confirmation shortly.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue Shopping'),
          ),
          ElevatedButton(
            onPressed: () {
              // Close this dialog
              Navigator.pop(context);
              // Show success dialog
              _showOrderSuccessDialog(context, ref);
            },
            child: const Text('Confirm Order'),
          ),
        ],
      ),
    );
  }

  void _showOrderSuccessDialog(BuildContext context, WidgetRef ref) {
    final cartState = ref.read(cartProvider);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 24),
            const SizedBox(width: 8),
            const Text('Order Placed!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your order for ${cartState.totalQuantity} items has been placed successfully!',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              'Order Total: \$${cartState.grandTotal.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Order ID: ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'You will receive an email with order details and tracking information.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(cartProvider.notifier).clearCart();
              Navigator.pop(context); // Close success dialog
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: const Text('Continue Shopping'),
          ),
          TextButton(
            onPressed: () {
              ref.read(cartProvider.notifier).clearCart();
              Navigator.pop(context); // Close success dialog
              Navigator.pushReplacementNamed(context, '/orders');
            },
            child: const Text('View Orders'),
          ),
        ],
      ),
    );
  }
}