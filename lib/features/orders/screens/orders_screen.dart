import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/orders_provider.dart';
import '../widgets/order_tile.dart';
import '../../../shared/widgets/empty_state.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersState = ref.watch(ordersNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ordersState.orders.isEmpty
          ? EmptyState(
              title: 'No Orders Yet',
              message: 'Your order history will appear here',
              icon: Icons.shopping_bag_outlined,
              buttonText: 'Start Shopping',
              onButtonPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ordersState.orders.length,
              itemBuilder: (context, index) {
                final order = ordersState.orders[index];
                return OrderTile(
                  order: order,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/order-detail',
                      arguments: order.id,
                    );
                  },
                );
              },
            ),
    );
  }
}