// import 'package:flutter/material.dart';
//
// import '../../../../core/models/order.dart';
//
//
//
//
// // Order Card
// class OrderCard extends StatelessWidget {
//   final Order order;
//
//   const OrderCard({required this.order});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.only(bottom: 12),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Order #${order.id.substring(order.id.length - 4)}',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: _getStatusColor(order.status as String),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     order.status.toString().toUpperCase(),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Placed on: ${_formatDate(order.orderDate)}',
//               style: TextStyle(color: Colors.grey.shade600),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Items: ${order.items.length}',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Total:',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   '\$${order.totalAmount.toStringAsFixed(2)}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green.shade700,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'delivered':
//         return Colors.green;
//       case 'processing':
//         return Colors.orange;
//       case 'pending':
//         return Colors.blue;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }
// }