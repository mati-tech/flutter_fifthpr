// lib/data/datasources/favorite_api_datasource.dart

abstract class FavoriteApiDataSource {
  // Add to favorites
  Future<Map<String, dynamic>> addToFavorites(String productId);

  // Remove from favorites
  Future<void> removeFromFavorites(String favoriteId);

  // Get all favorites
  Future<List<Map<String, dynamic>>> getFavorites();

  // Check if product is favorite
  Future<bool> isFavorite(String productId);

  // Clear all favorites
  Future<void> clearFavorites();

  // Get favorite by ID
  Future<Map<String, dynamic>> getFavoriteById(String id);
}

// lib/data/datasources/mock_favorite_api_datasource.dart
// import 'favorite_api_datasource.dart';

class MockFavoriteApiDataSource implements FavoriteApiDataSource {
  final List<Map<String, dynamic>> _mockFavorites = [];
  int _nextId = 1;

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<Map<String, dynamic>> addToFavorites(String productId) async {
    await _simulateDelay();

    // Check if already favorited
    final existing = _mockFavorites.firstWhere(
          (fav) => fav['product_id'] == productId,
      orElse: () => {},
    );

    if (existing.isNotEmpty) {
      throw Exception('Product already in favorites');
    }

    final newFavorite = {
      'id': 'fav_${_nextId++}',
      'product_id': productId,
      'added_at': DateTime.now().toIso8601String(),
    };

    _mockFavorites.add(newFavorite);
    return newFavorite;
  }

  @override
  Future<void> removeFromFavorites(String favoriteId) async {
    await _simulateDelay();

    _mockFavorites.removeWhere((fav) => fav['id'] == favoriteId);
  }

  @override
  Future<List<Map<String, dynamic>>> getFavorites() async {
    await _simulateDelay();
    return List.from(_mockFavorites);
  }

  @override
  Future<bool> isFavorite(String productId) async {
    await _simulateDelay();

    return _mockFavorites.any((fav) => fav['product_id'] == productId);
  }

  @override
  Future<void> clearFavorites() async {
    await _simulateDelay();
    _mockFavorites.clear();
  }

  @override
  Future<Map<String, dynamic>> getFavoriteById(String id) async {
    await _simulateDelay();

    return _mockFavorites.firstWhere(
          (fav) => fav['id'] == id,
      orElse: () => throw Exception('Favorite not found'),
    );
  }
}