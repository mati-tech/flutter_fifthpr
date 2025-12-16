// lib/data/datasources/order_api_datasource.dart

abstract class OrderApiDataSource {
  // Create order
  Future<Map<String, dynamic>> createOrder({
    required List<Map<String, dynamic>> items,
    required String shippingAddress,
  });

  // Get orders
  Future<List<Map<String, dynamic>>> getOrders();

  // Get order by ID
  Future<Map<String, dynamic>> getOrderById(String id);

  // Cancel order
  Future<void> cancelOrder(String orderId);
}

class MockOrderApiDataSource implements OrderApiDataSource {
  final List<Map<String, dynamic>> _mockOrders = [];
  int _nextId = 1;

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<Map<String, dynamic>> createOrder({
    required List<Map<String, dynamic>> items,
    required String shippingAddress,
  }) async {
    await _simulateDelay();

    if (items.isEmpty) {
      throw Exception('Cannot create order with empty items');
    }

    // Calculate total
    final totalAmount = items.fold(0.0, (sum, item) {
      final price = (item['price'] ?? 0.0).toDouble();
      final quantity = (item['quantity'] ?? 1).toInt();
      return sum + (price * quantity);
    });

    final newOrder = {
      'id': 'order_${_nextId++}',
      'order_number': 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      'items': items,
      'total_amount': totalAmount,
      'order_date': DateTime.now().toIso8601String(),
      'status': 'pending',
      'shipping_address': shippingAddress,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };

    _mockOrders.add(newOrder);
    return newOrder;
  }

  @override
  Future<List<Map<String, dynamic>>> getOrders() async {
    await _simulateDelay();

    // Return sample orders if empty
    if (_mockOrders.isEmpty) {
      return _createSampleOrders();
    }

    return List.from(_mockOrders);
  }

  @override
  Future<Map<String, dynamic>> getOrderById(String id) async {
    await _simulateDelay();

    return _mockOrders.firstWhere(
          (order) => order['id'] == id,
      orElse: () => throw Exception('Order not found'),
    );
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await _simulateDelay();

    final index = _mockOrders.indexWhere((order) => order['id'] == orderId);

    if (index == -1) {
      throw Exception('Order not found');
    }

    _mockOrders[index]['status'] = 'cancelled';
    _mockOrders[index]['updated_at'] = DateTime.now().toIso8601String();
  }

  // Create sample orders for testing
  List<Map<String, dynamic>> _createSampleOrders() {
    return [
      {
        'id': 'order_1',
        'order_number': 'ORD-1001',
        'items': [
          {
            'product_id': '1',
            'name': 'iPhone 14 Pro',
            'price': 999.99,
            'quantity': 1,
            'image_url': 'https://picsum.photos/200/300?random=iphone',
          },
        ],
        'total_amount': 999.99,
        'order_date': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
        'status': 'delivered',
        'shipping_address': '123 Main St, New York, NY',
        'tracking_number': 'TRK123456789',
        'created_at': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
        'updated_at': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      },
      {
        'id': 'order_2',
        'order_number': 'ORD-1002',
        'items': [
          {
            'product_id': '3',
            'name': 'MacBook Air M2',
            'price': 1199.99,
            'quantity': 1,
            'image_url': 'https://picsum.photos/200/300?random=macbook',
          },
          {
            'product_id': '4',
            'name': 'Sony Headphones',
            'price': 349.99,
            'quantity': 1,
            'image_url': 'https://picsum.photos/200/300?random=headphones',
          },
        ],
        'total_amount': 1549.98,
        'order_date': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
        'status': 'shipped',
        'shipping_address': '456 Oak Ave, Los Angeles, CA',
        'tracking_number': 'TRK987654321',
        'created_at': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
    ];
  }
}