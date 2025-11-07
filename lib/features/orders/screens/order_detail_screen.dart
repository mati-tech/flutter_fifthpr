import 'package:flutter/material.dart';
import '../../../shared/app_theme.dart';
import '../state/orders_container.dart';
import '../models/order.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../core/setup_di.dart';
import '../../../core/widgets/listenable_builder.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context)!.settings.arguments as String;
    return ContainerListenableBuilder<OrdersContainer>(
      getNotifier: () => getIt<OrdersContainer>(),
      builder: (context, ordersContainer) {
        final order = ordersContainer.getOrder(orderId);

        if (order == null) {
          return const Scaffold(
            body: Center(child: Text('Order not found')),
          );
        }

        return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order #${order.id.substring(order.id.length - 6)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: order.status.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: order.status.color),
                          ),
                          child: Text(
                            order.status.displayName,
                            style: TextStyle(
                              color: order.status.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Placed on ${AppUtils.formatDateTime(order.orderDate)}',
                      style: TextStyle(color: AppTheme.secondaryColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${order.itemCount} ${order.itemCount == 1 ? 'item' : 'items'}',
                      style: const TextStyle(color: AppTheme.secondaryColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Shipping Address
            const Text(
              'Shipping Address',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(order.shippingAddress),
              ),
            ),
            const SizedBox(height: 20),
            // Order Items
            const Text(
              'Order Items',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  ...order.items.map(
                        (item) => ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: NetworkImage(item.product.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(item.product.name),
                      subtitle: Text('Qty: ${item.quantity}'),
                      trailing: Text(
                        AppUtils.formatPrice(item.totalPrice),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      AppUtils.formatPrice(order.totalAmount),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Actions
            if (order.status == OrderStatus.pending) ...[
              AppButton(
                text: 'Cancel Order',
                onPressed: () {
                  // Implement cancel order
                },
                backgroundColor: AppTheme.errorColor,
              ),
              const SizedBox(height: 8),
            ],
            if (order.trackingNumber != null) ...[
              AppButton(
                text: 'Track Package',
                onPressed: () {
                  // Implement tracking
                },
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
        );
      },
    );
  }
}