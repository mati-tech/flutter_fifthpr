// // lib/domain/interfaces/repositories/cart_repository.dart
// import '../../../core/models/cart_item.dart';
// // import '../entities/cart_item.dart';
//
// abstract class CartRepository {
//   // Add item to cart
//   Future<CartItem> addToCart(String productId, {int quantity = 1});
//
//   // Remove item from cart
//   Future<void> removeFromCart(String cartItemId);
//
//   // Update item quantity
//   Future<CartItem> updateQuantity(String cartItemId, int quantity);
//
//   // Get all cart items
//   Future<List<CartItem>> getCartItems();
//
//   // Get cart item by ID
//   Future<CartItem?> getCartItemById(String id);
//
//   // Get cart item by product ID
//   Future<CartItem?> getCartItemByProductId(String productId);
//
//   // Clear entire cart
//   Future<void> clearCart();
//
//   // Get cart total
//   Future<double> getCartTotal();
//
//   // Get cart items count
//   Future<int> getCartItemsCount();
//
//   // Get total quantity (sum of all items' quantities)
//   Future<int> getTotalQuantity();
//
//   // Check if product is in cart
//   Future<bool> isInCart(String productId);
//
//   // Apply coupon/discount
//   Future<double> applyCoupon(String couponCode);
//
//   // Calculate shipping cost
//   Future<double> calculateShipping(String address);
// }