// // import 'package:flutter/material.dart';
// // import '../models/cart_item.dart';
// // import '../../home/models/product.dart';
// //
// // class CartContainer extends ChangeNotifier {
// //   final List<CartItem> _cartItems = [];
// //
// //   List<CartItem> get cartItems => _cartItems;
// //   int get cartItemsCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
// //   double get totalPrice => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
// //
// //   void addToCart(Product product, {int quantity = 1}) {
// //     final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);
// //
// //     if (existingIndex != -1) {
// //       _cartItems[existingIndex].quantity += quantity;
// //     } else {
// //       _cartItems.add(CartItem(
// //         id: DateTime.now().millisecondsSinceEpoch.toString(),
// //         product: product,
// //         quantity: quantity,
// //       ));
// //     }
// //     notifyListeners();
// //   }
// //
// //   void removeFromCart(String productId) {
// //     _cartItems.removeWhere((item) => item.product.id == productId);
// //     notifyListeners();
// //   }
// //
// //   void updateQuantity(String productId, int newQuantity) {
// //     if (newQuantity <= 0) {
// //       removeFromCart(productId);
// //       return;
// //     }
// //
// //     final existingIndex = _cartItems.indexWhere((item) => item.product.id == productId);
// //     if (existingIndex != -1) {
// //       _cartItems[existingIndex].quantity = newQuantity;
// //       notifyListeners();
// //     }
// //   }
// //
// //   void incrementQuantity(String productId) {
// //     updateQuantity(productId, getQuantity(productId) + 1);
// //   }
// //
// //   void decrementQuantity(String productId) {
// //     updateQuantity(productId, getQuantity(productId) - 1);
// //   }
// //
// //   int getQuantity(String productId) {
// //     final item = _cartItems.firstWhere(
// //           (item) => item.product.id == productId,
// //       orElse: () => CartItem(id: '', product: Product(
// //         id: '', name: '', description: '', price: 0, imageUrl: '', category: '', stock: 0,
// //       )),
// //     );
// //     return item.quantity;
// //   }
// //
// //   void clearCart() {
// //     _cartItems.clear();
// //     notifyListeners();
// //   }
// //
// //   bool isInCart(String productId) {
// //     return _cartItems.any((item) => item.product.id == productId);
// //   }
// // }
//
//
// // lib/features/cart/providers/cart_provider.dart
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import '../models/cart_item.dart';
// import '../../home/models/product.dart';
//
// part 'cart_provider.g.dart';
//
// @riverpod
// class CartNotifier extends _$CartNotifier {
//   @override
//   CartState build() {
//     return CartState(cartItems: []);
//   }
//
//   void addToCart(Product product, {int quantity = 1}) {
//     final currentItems = List<CartItem>.from(state.cartItems);
//     final existingIndex = currentItems.indexWhere(
//           (item) => item.product.id == product.id,
//     );
//
//     if (existingIndex != -1) {
//       currentItems[existingIndex] = currentItems[existingIndex].copyWith(
//         quantity: currentItems[existingIndex].quantity + quantity,
//       );
//     } else {
//       currentItems.add(CartItem(
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//         product: product,
//         quantity: quantity,
//       ));
//     }
//
//     state = CartState(cartItems: currentItems);
//   }
//
//   void removeFromCart(String productId) {
//     final currentItems = List<CartItem>.from(state.cartItems);
//     currentItems.removeWhere((item) => item.product.id == productId);
//     state = CartState(cartItems: currentItems);
//   }
//
//   void updateQuantity(String productId, int newQuantity) {
//     if (newQuantity <= 0) {
//       removeFromCart(productId);
//       return;
//     }
//
//     final currentItems = List<CartItem>.from(state.cartItems);
//     final existingIndex = currentItems.indexWhere(
//           (item) => item.product.id == productId,
//     );
//
//     if (existingIndex != -1) {
//       currentItems[existingIndex] = currentItems[existingIndex].copyWith(
//         quantity: newQuantity,
//       );
//       state = CartState(cartItems: currentItems);
//     }
//   }
//
//   void incrementQuantity(String productId) {
//     updateQuantity(productId, getQuantity(productId) + 1);
//   }
//
//   void decrementQuantity(String productId) {
//     updateQuantity(productId, getQuantity(productId) - 1);
//   }
//
//   int getQuantity(String productId) {
//     final item = state.cartItems.firstWhere(
//           (item) => item.product.id == productId,
//       orElse: () => CartItem(
//         id: '',
//         product: Product(
//           id: '',
//           name: '',
//           description: '',
//           price: 0,
//           imageUrl: '',
//           category: '',
//           stock: 0,
//         ),
//       ),
//     );
//     return item.quantity;
//   }
//
//   void clearCart() {
//     state = CartState(cartItems: []);
//   }
//
//   bool isInCart(String productId) {
//     return state.cartItems.any((item) => item.product.id == productId);
//   }
// }
//
// class CartState {
//   final List<CartItem> cartItems;
//
//   CartState({required this.cartItems});
//
//   int get cartItemsCount => cartItems.fold(0, (sum, item) => sum + item.quantity);
//   double get totalPrice =>
//       cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
// }