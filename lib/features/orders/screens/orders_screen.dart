import 'package:flutter/material.dart';
import '../state/orders_container.dart';
import '../widgets/order_tile.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../core/setup_di.dart';
import '../../../core/widgets/listenable_builder.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerListenableBuilder<OrdersContainer>(
      getNotifier: () => getIt<OrdersContainer>(),
      builder: (context, ordersContainer) {
        return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ordersContainer.orders.isEmpty
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
        itemCount: ordersContainer.orders.length,
        itemBuilder: (context, index) {
          final order = ordersContainer.orders[index];
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
      },
    );
  }
}