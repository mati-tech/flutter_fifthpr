// import 'product.dart';
//
// /// Domain entity representing an item in the shopping cart
// /// Pure Dart class - no Flutter dependencies
// // class CartItem {
// //   final String id;
// //   final Product product;
// //   int quantity;
// //
// //   CartItem({
// //     required this.id,
// //     required this.product,
// //     this.quantity = 1,
// //   });
// //
// //   double get totalPrice => product.price * quantity;
// //
// //   CartItem copyWith({
// //     int? quantity,
// //   }) {
// //     return CartItem(
// //       id: id,
// //       product: product,
// //       quantity: quantity ?? this.quantity,
// //     );
// //   }
// // }
//
// // lib/domain/entities/cart_item.dart
// import 'product.dart';
//
// class CartItem {
//   final String id;
//   final Product product;
//   int quantity;
//
//   CartItem({
//     required this.id,
//     required this.product,
//     this.quantity = 1,
//   });
//
//   // Calculated properties
//   double get totalPrice => product.price * quantity;
//
//   // Check if product has discount
//   double get totalDiscountedPrice {
//     final original = product.originalPrice ?? product.price;
//     return original * quantity;
//   }
//
//   double get discountAmount => totalDiscountedPrice - totalPrice;
//
//   // Check stock availability
//   bool get isInStock => quantity <= product.stockQuantity;
//
//   bool get canIncrease => quantity < product.stockQuantity;
//
//   CartItem copyWith({
//     String? id,
//     Product? product,
//     int? quantity,
//   }) {
//     return CartItem(
//       id: id ?? this.id,
//       product: product ?? this.product,
//       quantity: quantity ?? this.quantity,
//     );
//   }
//
//   // Increase quantity
//   CartItem increaseQuantity([int amount = 1]) {
//     return copyWith(quantity: quantity + amount);
//   }
//
//   // Decrease quantity
//   CartItem decreaseQuantity([int amount = 1]) {
//     final newQuantity = quantity - amount;
//     return copyWith(quantity: newQuantity > 0 ? newQuantity : 1);
//   }
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     return other is CartItem &&
//         other.id == id &&
//         other.product == product;
//   }
//
//   @override
//   int get hashCode => id.hashCode ^ product.hashCode;
// }