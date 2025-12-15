// lib/data/repositories/favorite_repository_impl.dart
import '../../core/models/favorite_item.dart';
import '../../core/models/product.dart';
import '../../domain/interfaces/repositories/fav_repository.dart';
// import '../../domain/interfaces/repositories/favorite_repository.dart';
// import '../../domain/entities/favorite_item.dart';
// import '../../domain/entities/product.dart';
import '../datasources/api/Favorite_api_datasource.dart';
import '../datasources/api/dto/Favorite_dto.dart';
import '../datasources/api/product_api_datasource.dart';
// import '../datasources/favorite_api_datasource.dart';
// import '../datasources/product_api_datasource.dart'; // Need to get product details
// import '../mappers/favorite_mapper.dart';
// import '../dtos/favorite_dto.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteApiDataSource favoriteDataSource;
  final ProductApiDataSource productDataSource; // To get product details

  FavoriteRepositoryImpl({
    required this.favoriteDataSource,
    required this.productDataSource,
  });

  @override
  Future<FavoriteItem> addToFavorites(String productId) async {
    // 1. Add to favorites via data source
    final response = await favoriteDataSource.addToFavorites(productId);
    final favoriteDto = FavoriteDto.fromJson(response);

    // 2. Get product details
    final productResponse = await productDataSource.getProductById(productId);
    // You need ProductDto and ProductMapper here
    // final productDto = ProductDto.fromJson(productResponse);
    // final product = ProductMapper.toDomain(productDto);

    // 3. Return combined FavoriteItem
    // For now, create a dummy product
    final dummyProduct = Product(
      id: productId,
      name: 'Product $productId',
      description: '',
      price: 0,
      imageUrl: '',
      category: '',
      brand: '',
      stockQuantity: 0,
      isFeatured: false,
      createdAt: DateTime.now(),
    );

    return FavoriteItem(
      id: favoriteDto.id,
      product: dummyProduct,
      addedAt: favoriteDto.addedAt,
    );
  }

  @override
  Future<void> removeFromFavorites(String favoriteItemId) async {
    await favoriteDataSource.removeFromFavorites(favoriteItemId);
  }

  @override
  Future<void> removeFromFavoritesByProductId(String productId) async {
    // Need to find favorite ID first, then remove
    final favorites = await getFavorites();
    final favorite = favorites.firstWhere(
          (fav) => fav.product.id == productId,
      orElse: () => throw Exception('Favorite not found'),
    );

    await removeFromFavorites(favorite.id);
  }

  @override
  Future<List<FavoriteItem>> getFavorites() async {
    final favoritesData = await favoriteDataSource.getFavorites();

    // This is complex because we need product details for each favorite
    // In real app, you'd batch fetch products or join data

    // For mock, return empty list
    return [];
  }

  @override
  Future<bool> isFavorite(String productId) async {
    return await favoriteDataSource.isFavorite(productId);
  }

  @override
  Future<FavoriteItem?> getFavoriteById(String id) async {
    try {
      final data = await favoriteDataSource.getFavoriteById(id);
      final favoriteDto = FavoriteDto.fromJson(data);

      // Need product details...
      return null; // Simplified
    } catch (e) {
      return null;
    }
  }

  @override
  Future<FavoriteItem?> getFavoriteByProductId(String productId) async {
    final favorites = await getFavorites();
    try {
      return favorites.firstWhere((fav) => fav.product.id == productId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearFavorites() async {
    await favoriteDataSource.clearFavorites();
  }

  @override
  Future<int> getFavoritesCount() async {
    final favorites = await getFavorites();
    return favorites.length;
  }
}