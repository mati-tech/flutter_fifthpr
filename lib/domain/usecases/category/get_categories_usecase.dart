// import '../../../core/models/category.dart';
// import '../../interfaces/repositories/product_repository.dart';
//
// /// Use case for getting all categories
// /// Single responsibility: Fetch all available product categories
// class GetCategoriesUseCase {
//   final ProductRepository _repository;
//
//   GetCategoriesUseCase(this._repository);
//
//   /// Execute the use case
//   /// Returns a list of all categories
//   /// Throws Exception if the operation fails
//   Future<List<Category>> execute() async {
//     try {
//       return await _repository.getCategories();
//     } catch (e) {
//       throw Exception('Failed to fetch categories: ${e.toString()}');
//     }
//   }
// }
//
