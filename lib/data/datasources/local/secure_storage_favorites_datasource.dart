// lib/data/datasources/local/secure_storage_favorites_datasource.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SecureStorageFavoritesDataSource {
  // Настройки безопасного хранилища
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.unlocked,
    ),
  );

  static const String _favoritesKey = 'storelytech_favorites';

  // Сохранить все избранные товары
  Future<void> saveFavorites(List<Map<String, dynamic>> favorites) async {
    try {
      if (favorites.isEmpty) {
        await _storage.delete(key: _favoritesKey);
        return;
      }

      final jsonString = json.encode(favorites);
      await _storage.write(key: _favoritesKey, value: jsonString);
      print('DEBUG: Saved ${favorites.length} favorites to secure storage');
    } catch (e) {
      print('ERROR saving favorites to secure storage: $e');
      rethrow;
    }
  }

  // Получить все избранные товары
  Future<List<Map<String, dynamic>>> getFavorites() async {
    try {
      final jsonString = await _storage.read(key: _favoritesKey);

      if (jsonString == null || jsonString.isEmpty) {
        print('DEBUG: No favorites found in secure storage');
        return [];
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      final favorites = jsonList.cast<Map<String, dynamic>>().toList();
      print('DEBUG: Loaded ${favorites.length} favorites from secure storage');
      return favorites;
    } catch (e) {
      print('ERROR loading favorites from secure storage: $e');
      return [];
    }
  }

  // Добавить товар в избранное
  Future<bool> addFavorite(Map<String, dynamic> product) async {
    try {
      final favorites = await getFavorites();

      // Проверяем, не добавлен ли уже товар
      final exists = favorites.any((fav) => fav['id'] == product['id']);
      if (exists) {
        print('DEBUG: Product ${product['id']} already in favorites');
        return false;
      }

      // Добавляем метку времени
      final favoriteWithTimestamp = {
        ...product,
        'addedAt': DateTime.now().toIso8601String(),
      };

      favorites.add(favoriteWithTimestamp);
      await saveFavorites(favorites);
      print('DEBUG: Added product ${product['id']} to favorites');
      return true;
    } catch (e) {
      print('ERROR adding favorite: $e');
      return false;
    }
  }

  // Удалить товар из избранного
  Future<bool> removeFavorite(String productId) async {
    try {
      final favorites = await getFavorites();
      final initialCount = favorites.length;

      favorites.removeWhere((fav) => fav['id'] == productId);

      if (favorites.length < initialCount) {
        await saveFavorites(favorites);
        print('DEBUG: Removed product $productId from favorites');
        return true;
      }

      print('DEBUG: Product $productId not found in favorites');
      return false;
    } catch (e) {
      print('ERROR removing favorite: $e');
      return false;
    }
  }

  // Проверить, есть ли товар в избранном
  Future<bool> isFavorite(String productId) async {
    try {
      final favorites = await getFavorites();
      return favorites.any((fav) => fav['id'] == productId);
    } catch (e) {
      print('ERROR checking favorite: $e');
      return false;
    }
  }

  // Очистить все избранные
  Future<void> clearAllFavorites() async {
    try {
      await _storage.delete(key: _favoritesKey);
      print('DEBUG: Cleared all favorites');
    } catch (e) {
      print('ERROR clearing favorites: $e');
    }
  }

  // Получить количество избранных
  Future<int> getFavoritesCount() async {
    final favorites = await getFavorites();
    return favorites.length;
  }

  // Получить информацию о хранилище (для отладки)
  Future<Map<String, dynamic>> getStorageInfo() async {
    try {
      final value = await _storage.read(key: _favoritesKey);
      return {
        'hasData': value != null,
        'dataLength': value?.length ?? 0,
        'keys': await _storage.readAll(),
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}