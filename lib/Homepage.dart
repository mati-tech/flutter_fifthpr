import 'package:flutter/material.dart';

import 'features/auth/login_screen.dart';
import 'features/cart/cart_screen.dart';
import 'features/orders/orders_screen.dart';
import 'features/products/product_detail_screen.dart';
import 'features/products/products_screen.dart';
import 'models/cart_item.dart';
import 'models/order.dart';
import 'models/product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Product> _products = [];
  List<CartItem> _cartItems = [];
  List<Order> _orders = [];
  bool _isLoggedIn = true; // Start as logged in for demo
  String _currentScreen = 'products'; // 'products', 'cart', 'orders'

  // Initialize with sample data
  @override
  void initState() {
    super.initState();
    _loadSampleProducts();
    _loadSampleOrders();
  }

  void _loadSampleProducts() {
    setState(() {
      _products = [
        Product(
          id: '1',
          title: 'Wireless Headphones',
          description: 'High-quality wireless headphones with noise cancellation. Perfect for music lovers and professionals who need focus.',
          price: 99.99,
          imageUrl: 'assets/headphones.jpg',
          stockQuantity: 15,
          isAvailable: true,
        ),
        Product(
          id: '2',
          title: 'Smartphone Pro',
          description: 'Latest smartphone with advanced camera system and long-lasting battery.',
          price: 699.99,
          imageUrl: 'assets/phone.jpg',
          stockQuantity: 8,
          isAvailable: true,
        ),
        Product(
          id: '3',
          title: 'Laptop Ultra',
          description: 'Powerful laptop for work and gaming with high-performance processor.',
          price: 1299.99,
          imageUrl: 'assets/laptop.jpg',
          stockQuantity: 5,
          isAvailable: true,
        ),
        Product(
          id: '4',
          title: 'Smart Watch',
          description: 'Feature-rich smartwatch with health monitoring and notifications.',
          price: 249.99,
          imageUrl: 'assets/watch.jpg',
          stockQuantity: 20,
          isAvailable: true,
        ),
        Product(
          id: '5',
          title: 'Bluetooth Speaker',
          description: 'Portable speaker with crystal clear sound and waterproof design.',
          price: 79.99,
          imageUrl: 'assets/speaker.jpg',
          stockQuantity: 0,
          isAvailable: false,
        ),
      ];
    });
  }

  void _loadSampleOrders() {
    setState(() {
      _orders = [
        Order(
          id: '1001',
          items: [
            CartItem(
              id: 'temp1',
              product: _products[0],
              quantity: 1,
            ),
          ],
          totalAmount: 99.99,
          orderDate: DateTime.now().subtract(Duration(days: 5)),
          status: 'delivered',
        ),
      ];
    });
  }

  // Business logic methods
  void addToCart(Product product, [int quantity = 1]) {
    if (!product.isAvailable) return;

    setState(() {
      final existingItemIndex = _cartItems.indexWhere((item) => item.product.id == product.id);

      if (existingItemIndex >= 0) {
        // Update quantity if item already in cart
        final existingItem = _cartItems[existingItemIndex];
        _cartItems[existingItemIndex] = CartItem(
          id: existingItem.id,
          product: existingItem.product,
          quantity: existingItem.quantity + quantity,
        );
      } else {
        // Add new item to cart
        _cartItems.add(CartItem(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          product: product,
          quantity: quantity,
        ));
      }

      // Show confirmation snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.title} added to cart!'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  void removeFromCart(String cartItemId) {
    final removedItem = _cartItems.firstWhere((item) => item.id == cartItemId);

    setState(() {
      _cartItems.removeWhere((item) => item.id == cartItemId);
    });

    // Show undo snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedItem.product.title} removed from cart'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _cartItems.add(removedItem);
            });
          },
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void updateCartQuantity(String cartItemId, int newQuantity) {
    setState(() {
      final index = _cartItems.indexWhere((item) => item.id == cartItemId);
      if (index >= 0 && newQuantity > 0) {
        final item = _cartItems[index];
        _cartItems[index] = CartItem(
          id: item.id,
          product: item.product,
          quantity: newQuantity,
        );
      } else if (newQuantity <= 0) {
        removeFromCart(cartItemId);
      }
    });
  }

  void placeOrder() {
    if (_cartItems.isEmpty) return;

    setState(() {
      final newOrder = Order(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        items: List.from(_cartItems),
        totalAmount: _calculateTotal(),
        orderDate: DateTime.now(),
        status: 'processing',
      );

      _orders.add(newOrder);
      _cartItems.clear(); // Clear cart after order
      _currentScreen = 'orders'; // Navigate to orders screen
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order placed successfully!'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  double _calculateTotal() {
    return _cartItems.fold(0, (total, item) => total + (item.product.price * item.quantity));
  }

  void navigateTo(String screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  void logout() {
    setState(() {
      _isLoggedIn = false;
      _cartItems.clear();
      _currentScreen = 'products';
    });
  }

  void login() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  // Build different screens based on current state
  Widget _buildProductsScreen() {
    return ProductsScreen(
      products: _products,
      onAddToCart: addToCart,
      onViewCart: () => navigateTo('cart'),
      cartItemCount: _cartItems.length,
      onViewProductDetails: (product) {
        // For simplicity, we'll show a dialog instead of a new screen
        showDialog(
          context: context,
          builder: (context) => ProductDetailDialog(product: product, onAddToCart: addToCart),
        );
      },
    );
  }

  Widget _buildCartScreen() {
    return CartScreen(
      cartItems: _cartItems,
      onUpdateQuantity: updateCartQuantity,
      onRemoveItem: removeFromCart,
      onPlaceOrder: placeOrder,
      totalAmount: _calculateTotal(),
      onContinueShopping: () => navigateTo('products'),
    );
  }

  Widget _buildOrdersScreen() {
    return OrdersScreen(
      orders: _orders,
      onBackToShopping: () => navigateTo('products'),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoggedIn) {
      return LoginScreen(onLogin: login);
    }

    Widget currentScreen;

    switch (_currentScreen) {
      case 'cart':
        currentScreen = _buildCartScreen();
        break;
      case 'orders':
        currentScreen = _buildOrdersScreen();
        break;
      default:
        currentScreen = _buildProductsScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Storely'),

        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        actions: [
          // Cart icon with badge
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () => navigateTo('cart'),
              ),
              if (_cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      _cartItems.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          // Orders icon
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: () => navigateTo('orders'),
          ),
          // Logout icon
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: currentScreen,
      // Bottom navigation for easier navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreen == 'products' ? 0 : _currentScreen == 'cart' ? 1 : 2,
        onTap: (index) {
          switch (index) {
            case 0:
              navigateTo('products');
              break;
            case 1:
              navigateTo('cart');
              break;
            case 2:
              navigateTo('orders');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart (${_cartItems.length})',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Orders',
          ),
        ],
      ),
    );
  }
}