import 'package:flutter/material.dart';

import '../../models/order.dart';
import 'orders_card.dart';

// Orders Screen
class OrdersScreen extends StatelessWidget {
  final List<Order> orders;
  final VoidCallback onBackToShopping;

  const OrdersScreen({
    required this.orders,
    required this.onBackToShopping,
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
              Icon(Icons.history, color: Colors.blue.shade800),
              SizedBox(width: 8),
              Text(
                'Order History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              Spacer(),
              Text(
                '${orders.length} orders',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        // Orders List or Empty State
        Expanded(
          child: orders.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history, size: 64, color: Colors.grey.shade400),
                SizedBox(height: 16),
                Text(
                  'No orders yet',
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onBackToShopping,
                  child: Text('Start Shopping'),
                ),
              ],
            ),
          )
              : ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderCard(order: order);
            },
          ),
        ),
      ],
    );
  }
}