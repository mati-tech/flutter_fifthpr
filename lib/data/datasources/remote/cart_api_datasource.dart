// lib/data/datasources/cart_api_datasource.dart

abstract class CartApiDataSource {
  // Add to cart
  Future<Map<String, dynamic>> addToCart(String productId, int quantity);

  // Remove from cart
  Future<void> removeFromCart(String cartItemId);

  // Update quantity
  Future<Map<String, dynamic>> updateQuantity(String cartItemId, int quantity);

  // Get all cart items
  Future<List<Map<String, dynamic>>> getCartItems();

  // Clear cart
  Future<void> clearCart();

  // Get cart summary
  Future<Map<String, dynamic>> getCartSummary();

  // Apply coupon
  Future<Map<String, dynamic>> applyCoupon(String couponCode);
}

// lib/data/datasources/mock_cart_api_datasource.dart
// import 'cart_api_datasource.dart';

class MockCartApiDataSource implements CartApiDataSource {
  final List<Map<String, dynamic>> _mockCart = [];
  int _nextId = 1;

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<Map<String, dynamic>> addToCart(String productId, int quantity) async {
    await _simulateDelay();

    // Check if already in cart
    final existingIndex = _mockCart.indexWhere(
          (item) => item['product_id'] == productId,
    );

    if (existingIndex != -1) {
      // Update quantity
      final currentQuantity = _mockCart[existingIndex]['quantity'] as int;
      _mockCart[existingIndex]['quantity'] = currentQuantity + quantity;
      _mockCart[existingIndex]['updated_at'] = DateTime.now().toIso8601String();

      return _mockCart[existingIndex];
    } else {
      // Add new item
      final newItem = {
        'id': 'cart_${_nextId++}',
        'product_id': productId,
        'quantity': quantity,
        'added_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      _mockCart.add(newItem);
      return newItem;
    }
  }

  @override
  Future<void> removeFromCart(String cartItemId) async {
    await _simulateDelay();

    _mockCart.removeWhere((item) => item['id'] == cartItemId);
  }

  @override
  Future<Map<String, dynamic>> updateQuantity(String cartItemId, int quantity) async {
    await _simulateDelay();

    final itemIndex = _mockCart.indexWhere((item) => item['id'] == cartItemId);

    if (itemIndex == -1) {
      throw Exception('Cart item not found');
    }

    if (quantity <= 0) {
      _mockCart.removeAt(itemIndex);
      throw Exception('Quantity must be greater than 0');
    }

    _mockCart[itemIndex]['quantity'] = quantity;
    _mockCart[itemIndex]['updated_at'] = DateTime.now().toIso8601String();

    return _mockCart[itemIndex];
  }

  @override
  Future<List<Map<String, dynamic>>> getCartItems() async {
    await _simulateDelay();
    return List.from(_mockCart);
  }

  @override
  Future<void> clearCart() async {
    await _simulateDelay();
    _mockCart.clear();
  }

  @override
  Future<Map<String, dynamic>> getCartSummary() async {
    await _simulateDelay();

    int totalItems = 0;
    int totalQuantity = 0;

    for (final item in _mockCart) {
      totalItems++;
      totalQuantity += item['quantity'] as int;
    }

    return {
      'total_items': totalItems,
      'total_quantity': totalQuantity,
      'item_count': _mockCart.length,
    };
  }

  @override
  Future<Map<String, dynamic>> applyCoupon(String couponCode) async {
    await _simulateDelay();

    if (couponCode.isEmpty) {
      throw Exception('Coupon code is required');
    }

    // Mock coupon validation
    final validCoupons = ['SAVE10', 'WELCOME20', 'FLASH30'];

    if (!validCoupons.contains(couponCode.toUpperCase())) {
      throw Exception('Invalid coupon code');
    }

    double discount = 0;
    switch (couponCode.toUpperCase()) {
      case 'SAVE10':
        discount = 10;
        break;
      case 'WELCOME20':
        discount = 20;
        break;
      case 'FLASH30':
        discount = 30;
        break;
    }

    return {
      'coupon_code': couponCode,
      'discount_percentage': discount,
      'message': 'Coupon applied successfully',
    };
  }
}