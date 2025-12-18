import 'package:flutter/material.dart';
import '../../../../core/models/order.dart';
// import '../../../../domain/entities/order.dart';
import '../../../shared/app_theme.dart';
import '../../../shared/utils.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;

  const OrderTile({
    super.key,
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.shopping_bag_outlined,
            color: AppTheme.primaryColor,
          ),
        ),
        // title: Text(
        //   // order.orderNumber, // ← Changed: orderNumber instead of id
        //   style: const TextStyle(
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${order.itemCount} ${order.itemCount == 1 ? 'item' : 'items'}',
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(
              AppUtils.formatDate(order.orderDate),
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 4),
            // Text(
            //   AppUtils.formatPrice(order.grandTotal), // ← Changed: grandTotal
            //   style: const TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16,
            //     color: AppTheme.primaryColor,
            //   ),
            // ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(order.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _getStatusText(order.status), // ← Changed: helper method
                style: TextStyle(
                  fontSize: 12,
                  color: _getStatusColor(order.status),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  // Add these helper methods
  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending: return 'Pending';
      case OrderStatus.confirmed: return 'Confirmed';
      // case OrderStatus.processing: return 'Processing';
      case OrderStatus.shipped: return 'Shipped';
      case OrderStatus.delivered: return 'Delivered';
      case OrderStatus.cancelled: return 'Cancelled';
      // case OrderStatus.refunded: return 'Refunded';
    }
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending: return const Color(0xFFFF9800);
      case OrderStatus.confirmed: return const Color(0xFF2196F3);
      // case OrderStatus.processing: return const Color(0xFF9C27B0);
      case OrderStatus.shipped: return const Color(0xFF3F51B5);
      case OrderStatus.delivered: return const Color(0xFF4CAF50);
      case OrderStatus.cancelled: return const Color(0xFFF44336);
      // case OrderStatus.refunded: return const Color(0xFF607D8B);
    }
  }
}