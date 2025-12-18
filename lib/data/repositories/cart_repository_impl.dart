// lib/data/repositories/cart_repository_impl.dart
import '../../core/models/cart_item.dart';
import '../../core/models/product.dart';
import '../../domain/interfaces/repositories/cart_repository.dart';
// import '../../domain/entities/cart_item.dart';
// import '../../domain/entities/product.dart';
import '../datasources/Remote/cart_api_datasource.dart';
import '../datasources/Remote/order_api_datasource.dart';
import '../datasources/Remote/product_api_datasource.dart';
// import '../datasources/cart_api_datasource.dart';
// import '../datasources/product_api_datasource.dart';

class CartRepositoryImpl implements CartRepository {
  final CartApiDataSource cartDataSource;
  final ProductApiDataSource productDataSource;

  // Cache for cart items
  List<CartItem> _cachedCartItems = [];

  CartRepositoryImpl({
    required this.cartDataSource,
    required this.productDataSource,
  });

  // Helper to fetch and cache cart items
  Future<List<CartItem>> _fetchCartItems() async {
    final cartData = await cartDataSource.getCartItems();

    // Convert to CartItem objects
    _cachedCartItems = await Future.wait(cartData.map((item) async {
      // Get product details
      final productId = item['product_id']?.toString() ?? '';

      // Create dummy product (in real app, fetch from productDataSource)
      final dummyProduct = Product(
        id: productId,
        name: 'Product $productId',
        description: 'Description for product $productId',
        price: 99.99,
        imageUrl: '',
        category: 'Electronics',
        brand: 'Brand',
        stockQuantity: 10,
        isFeatured: false,
        createdAt: DateTime.now(),
      );

      return CartItem(
        id: item['id']?.toString() ?? '',
        product: dummyProduct,
        quantity: item['quantity'] as int? ?? 1,
      );
    }));

    return _cachedCartItems;
  }

  @override
  Future<CartItem> addToCart(String productId, {int quantity = 1}) async {
    // 1. Add to cart via data source
    final response = await cartDataSource.addToCart(productId, quantity);

    // 2. Create dummy product
    final dummyProduct = Product(
      id: productId,
      name: 'Product $productId',
      description: '',
      price: 99.99,
      imageUrl: '',
      category: '',
      brand: '',
      stockQuantity: 10,
      isFeatured: false,
      createdAt: DateTime.now(),
    );

    // 3. Create CartItem
    final newCartItem = CartItem(
      id: response['id']?.toString() ?? '',
      product: dummyProduct,
      quantity: response['quantity'] as int? ?? quantity,
    );

    // 4. Update cache
    await _fetchCartItems();

    return newCartItem;
  }

  @override
  Future<void> removeFromCart(String cartItemId) async {
    await cartDataSource.removeFromCart(cartItemId);
    await _fetchCartItems(); // Update cache
  }

  @override
  Future<CartItem> updateQuantity(String cartItemId, int quantity) async {
    final response = await cartDataSource.updateQuantity(cartItemId, quantity);

    // Get product details (in real app, fetch product)
    final dummyProduct = Product(
      id: 'product_id',
      name: 'Product',
      description: '',
      price: 99.99,
      imageUrl: '',
      category: '',
      brand: '',
      stockQuantity: 10,
      isFeatured: false,
      createdAt: DateTime.now(),
    );

    await _fetchCartItems(); // Update cache

    return CartItem(
      id: response['id']?.toString() ?? '',
      product: dummyProduct,
      quantity: response['quantity'] as int? ?? quantity,
    );
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    // Return cached items or fetch if empty
    if (_cachedCartItems.isEmpty) {
      return await _fetchCartItems();
    }
    return _cachedCartItems;
  }

  @override
  Future<CartItem?> getCartItemById(String id) async {
    final items = await getCartItems();
    try {
      return items.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<CartItem?> getCartItemByProductId(String productId) async {
    final items = await getCartItems();
    try {
      return items.firstWhere((item) => item.product.id == productId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearCart() async {
    await cartDataSource.clearCart();
    _cachedCartItems.clear();
  }

  @override
  Future<double> getCartTotal() async {
    final items = await getCartItems(); // ✅ Added await
    return items.fold(0.0, (total, item) => item.totalPrice); // ✅ Now works
  }

  @override
  Future<int> getCartItemsCount() async {
    final items = await getCartItems(); // ✅ Added await
    return items.length; // ✅ Now works
  }

  @override
  Future<int> getTotalQuantity() async {
    final items = await getCartItems(); // ✅ Added await
    return items.fold(0, (total, item) =>  item.quantity); // ✅ Now works
  }


  @override
  Future<bool> isInCart(String productId) async {
    final items = await getCartItems();
    return items.any((item) => item.product.id == productId);
  }

  @override
  Future<double> applyCoupon(String couponCode) async {
    final response = await cartDataSource.applyCoupon(couponCode);
    return (response['discount_percentage'] as num).toDouble();
  }

  @override
  Future<double> calculateShipping(String address) async {
    // Mock shipping calculation
    await Future.delayed(const Duration(milliseconds: 300));

    if (address.toLowerCase().contains('new york')) {
      return 5.99;
    } else if (address.toLowerCase().contains('california')) {
      return 7.99;
    } else {
      return 9.99;
    }
  }
}