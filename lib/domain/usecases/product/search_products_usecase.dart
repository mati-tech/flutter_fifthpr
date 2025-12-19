// // lib/domain/usecases/products/search_products_usecase.dart
// import '../../../core/models/product.dart';
// import '../../interfaces/repositories/product_repository.dart';
// // import '../../entities/product.dart';
//
// class SearchProductsUseCase {
//   final ProductRepository repository;
//
//   SearchProductsUseCase(this.repository);
//
//   Future<List<Product>> execute(String query) async {
//     // Business logic: Trim and validate query
//     final trimmedQuery = query.trim();
//
//     if (trimmedQuery.isEmpty) {
//       return []; // Return empty list for empty query
//     }
//
//     if (trimmedQuery.length < 2) {
//       throw ArgumentError('Search query must be at least 2 characters');
//     }
//
//     return await repository.searchProducts(trimmedQuery);
//   }
// }