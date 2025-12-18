// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/models/cart_item.dart';
// import '../../../shared/app_theme.dart';
// import '../providers/cart_provider.dart';
// // import '../models/cart_item.dart';
// import '../../../shared/utils.dart';
//
// class CartTile extends ConsumerWidget {
//   final CartItem cartItem;
//
//   const CartTile({super.key, required this.cartItem});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             // Product Image
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 image: DecorationImage(
//                   image: NetworkImage(cartItem.product.imageUrl),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             // Product Info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     cartItem.product.name,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     AppUtils.formatPrice(cartItem.product.price),
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: AppTheme.primaryColor,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   // Quantity Controls
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.remove, size: 20),
//                         onPressed: () {
//                           ref
//                               .read(cartProvider.notifier);
//                               // .decrementQuantity(cartItem.product.id);
//                         },
//                         style: IconButton.styleFrom(
//                           backgroundColor: AppTheme.backgroundColor,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Text(
//                           cartItem.quantity.toString(),
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.add, size: 20),
//                         onPressed: () {
//                           ref
//                               .read(cartProvider.notifier);
//                               // .incrementQuantity(cartItem.product.id);
//                         },
//                         style: IconButton.styleFrom(
//                           backgroundColor: AppTheme.backgroundColor,
//                         ),
//                       ),
//                       const Spacer(),
//                       IconButton(
//                         icon: const Icon(Icons.delete_outline,
//                             color: AppTheme.errorColor),
//                         onPressed: () {
//                           ref
//                               .read(cartProvider.notifier)
//                               .removeFromCart(cartItem.product.id);
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// lib/presentation/features/cart/widgets/cart_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/cart_item.dart';
import '../../../shared/app_theme.dart';
import '../../../shared/utils.dart';

class CartTile extends ConsumerWidget {
  final CartItem cartItem;
  final VoidCallback onIncrement;     // ← ADD THIS
  final VoidCallback onDecrement;     // ← ADD THIS
  final VoidCallback onRemove;        // ← ADD THIS

  const CartTile({
    super.key,
    required this.cartItem,
    required this.onIncrement,        // ← ADD THIS
    required this.onDecrement,        // ← ADD THIS
    required this.onRemove,           // ← ADD THIS
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(cartItem.product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    cartItem.product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Price
                  Text(
                    AppUtils.formatPrice(cartItem.product.price),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.primaryColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Quantity Controls
                  Row(
                    children: [
                      // Decrement Button
                      IconButton(
                        icon: const Icon(Icons.remove, size: 20),
                        onPressed: onDecrement,  // ← USE CALLBACK
                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.backgroundColor,
                        ),
                      ),

                      // Quantity Display
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          cartItem.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Increment Button
                      IconButton(
                        icon: const Icon(Icons.add, size: 20),
                        onPressed: cartItem.canIncrease ? onIncrement : null, // ← USE CALLBACK
                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.backgroundColor,
                        ),
                      ),

                      const Spacer(),

                      // Item Total Price
                      Text(
                        AppUtils.formatPrice(cartItem.totalPrice),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Remove Button
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: AppTheme.errorColor),
                        onPressed: onRemove,  // ← USE CALLBACK
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}