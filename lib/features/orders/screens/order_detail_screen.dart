import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/app_theme.dart';
import '../providers/orders_provider.dart';
import '../models/order.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/app_button.dart';

class OrderDetailScreen extends ConsumerWidget {
  final String orderId;

  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersState = ref.watch(ordersNotifierProvider);
    final ordersNotifier = ref.read(ordersNotifierProvider.notifier);

    // Find the order by ID
    final order = ordersState.orders.firstWhere(
          (order) => order.id == orderId,
      orElse: () => Order(
        id: '',
        items: [],
        totalAmount: 0,
        orderDate: DateTime.now(),
        status: OrderStatus.pending,
        shippingAddress: '',
      ),
    );

    // If order not found
    if (order.id.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Order Details')),
        body: const Center(
          child: Text(
            'Order not found',
            style: TextStyle(fontSize: 18, color: AppTheme.secondaryColor),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
                  _showCancelOrderDialog(context, order, ordersNotifier);
                },
                backgroundColor: AppTheme.errorColor,
              ),
              const SizedBox(height: 8),
            ],
            if (order.trackingNumber != null && order.trackingNumber!.isNotEmpty) ...[
              AppButton(
                text: 'Track Package',
                onPressed: () {
                  _openTracking(context, order.trackingNumber!);
                },
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }

  void _showCancelOrderDialog(
      BuildContext context,
      Order order,
      OrdersNotifier ordersNotifier,
      ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Order?'),
        content: const Text('Are you sure you want to cancel this order?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              // Update order status to cancelled
              ordersNotifier.updateOrderStatus(order.id, OrderStatus.cancelled);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order cancelled successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: AppTheme.errorColor),
            ),
          ),
        ],
      ),
    );
  }

  void _openTracking(BuildContext context, String trackingNumber) {
    // In a real app, you would open tracking URL
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tracking number: $trackingNumber'),
        action: SnackBarAction(
          label: 'Copy',
          onPressed: () {
            // Copy to clipboard
          },
        ),
      ),
    );
  }
}