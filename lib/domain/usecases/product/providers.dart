
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storelytech/domain/usecases/product/search_products_usecase.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../data/repositories/providers.dart';
import '../cart/get_cart_items_usecase.dart';
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

final searchProductsUseCaseProvider =
Provider<SearchProductsUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return SearchProductsUseCase(repository);
});


final getCartByUserUseCaseProvider =
Provider<GetCartByUserUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetCartByUserUseCase(repository);
});