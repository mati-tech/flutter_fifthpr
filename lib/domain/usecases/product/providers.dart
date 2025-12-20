
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/providers.dart';
import '../user/delete_account_usecase.dart';
import '../user/get_currentuser_usecase.dart';
import 'get_featured_products_usecase.dart';
import 'get_product_by_id_usecase.dart';
import 'get_products_usecase.dart';

final getFeaturedProductsUseCaseProvider =
Provider<GetFeaturedProductsUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetFeaturedProductsUseCase(repository);
});


final getProductsUseCaseProvider =
Provider<GetProductsUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductsUseCase(repository);
});

final getProductsByIdUseCaseProvider =
Provider<GetProductsByIdUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductsByIdUseCase(repository);
});

final getUserByIdUseCaseProvider =
Provider<GetUserByIdUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetUserByIdUseCase(repository);
});


final deleteUserByIdUseCaseProvider =
Provider<DeleteUserByIdUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return DeleteUserByIdUseCase(repository);
});
