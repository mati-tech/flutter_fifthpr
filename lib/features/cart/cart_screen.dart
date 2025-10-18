import 'package:flutter/material.dart';


import 'cart_item.dart';
import 'models/cart_item.dart';

// Cart Screen
class CartScreen extends StatelessWidget {
  final List<CartItem> cartItems;
  final Function(String, int) onUpdateQuantity;
  final Function(String) onRemoveItem;
  final VoidCallback onPlaceOrder;
  final double totalAmount;
  final VoidCallback onContinueShopping;

  const CartScreen({
    required this.cartItems,
    required this.onUpdateQuantity,
    required this.onRemoveItem,
    required this.onPlaceOrder,
    required this.totalAmount,
    required this.onContinueShopping,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.blue.shade50,
          child: Row(
            children: [
              Icon(Icons.shopping_cart, color: Colors.blue.shade800),
              SizedBox(width: 8),
              Text(
                'Shopping Cart',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              Spacer(),
              Text(
                '${cartItems.length} items',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        // Cart Items or Empty State
        Expanded(
          child: cartItems.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey.shade400),
                SizedBox(height: 16),
                Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onContinueShopping,
                  child: Text('Start Shopping'),
                ),
              ],
            ),
          )
              : ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              return CartItemCard(
                cartItem: cartItem,
                onUpdateQuantity: (newQuantity) => onUpdateQuantity(cartItem.id, newQuantity),
                onRemove: () => onRemoveItem(cartItem.id),
              );
            },
          ),
        ),
        // Checkout Section
        if (cartItems.isNotEmpty)
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onContinueShopping,
                        child: Text('Continue Shopping'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onPlaceOrder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Checkout'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}