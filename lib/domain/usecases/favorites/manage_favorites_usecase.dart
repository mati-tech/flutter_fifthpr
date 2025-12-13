// lib/domain/usecases/manage_favorites_usecase.dart
import 'package:storelytech/core/models/favorite_item.dart';

import '../../../data/datasources/local/secure_storage_favorites_datasource.dart';
// import '../../data/datasources/local/secure_storage_favorites_datasource.dart';
// import '../models/favorite_product.dart';

class ManageFavoritesUseCase {
  final SecureStorageFavoritesDataSource _dataSource;

  ManageFavoritesUseCase(this._dataSource);

  // Получить все избранные товары
  Future<List<FavoriteItem>> getAllFavorites() async {
    try {
      final favoritesJson = await _dataSource.getFavorites();
      return favoritesJson
          .map((json) => FavoriteItem.fromJson(json))
          .toList();
    } catch (e) {
      print('UseCase ERROR getting all favorites: $e');
      return [];
    }
  }

  // Добавить товар в избранное
  Future<bool> addToFavorites(FavoriteItem product) async {
    try {
      return await _dataSource.addFavorite(product.toJson());
    } catch (e) {
      print('UseCase ERROR adding to favorites: $e');
      return false;
    }
  }

  // Удалить товар из избранного
  Future<bool> removeFromFavorites(String productId) async {
    try {
      return await _dataSource.removeFavorite(productId);
    } catch (e) {
      print('UseCase ERROR removing from favorites: $e');
      return false;
    }
  }

  // Проверить, есть ли товар в избранном
  Future<bool> isFavorite(String productId) async {
    try {
      return await _dataSource.isFavorite(productId);
    } catch (e) {
      print('UseCase ERROR checking favorite: $e');
      return false;
    }
  }

  // Очистить все избранное
  Future<void> clearAllFavorites() async {
    try {
      await _dataSource.clearAllFavorites();
    } catch (e) {
      print('UseCase ERROR clearing favorites: $e');
    }
  }

  // Получить количество избранных
  Future<int> getFavoritesCount() async {
    try {
      return await _dataSource.getFavoritesCount();
    } catch (e) {
      print('UseCase ERROR getting favorites count: $e');
      return 0;
    }
  }

  // Переключить состояние избранного
  Future<bool> toggleFavorite(FavoriteItem product) async {
    try {
      final isFav = await _dataSource.isFavorite(product.id);

      if (isFav) {
        await _dataSource.removeFavorite(product.id);
        return false;
      } else {
        await _dataSource.addFavorite(product.toJson());
        return true;
      }
    } catch (e) {
      print('UseCase ERROR toggling favorite: $e');
      return false;
    }
  }

  // Получить информацию о хранилище (для отладки)
  Future<Map<String, dynamic>> getStorageInfo() async {
    return await _dataSource.getStorageInfo();
  }

  // Простая версия добавления из базовых параметров
  Future<bool> addSimpleFavorite({
    required String id,
    required String name,
    String? imageUrl,
    required double price,
    String? category,
  }) async {
    final product = FavoriteItem(
      id: id,
      name: name,
      imageUrl: imageUrl,
      price: price,
      category: category,
      addedAt: DateTime.now(), product: null,
    );

    return await addToFavorites(product);
  }
}