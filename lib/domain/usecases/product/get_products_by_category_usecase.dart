// import '../../../core/models/product.dart';
// import '../../interfaces/repositories/product_repository.dart';
//
// /// Use case for getting products by category
// /// Single responsibility: Fetch products filtered by category
// class GetProductsByCategoryUseCase {
//   final ProductRepository _repository;
//
//   GetProductsByCategoryUseCase(this._repository);
//
//   /// Execute the use case
//   /// [categoryId] - The category ID to filter by
//   /// Returns a list of products in the specified category
//   /// Throws ArgumentError if categoryId is empty
//   /// Throws Exception if the operation fails
//   Future<List<Product>> execute(String categoryId) async {
//     if (categoryId.isEmpty) {
//       throw ArgumentError('Category ID cannot be empty');
//     }
//
//     try {
//       return await _repository.getProductsByCategory(categoryId);
//     } catch (e) {
//       throw Exception('Failed to fetch products by category: ${e.toString()}');
//     }
//   }
// }
//
