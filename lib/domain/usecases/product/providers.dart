
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/providers.dart';
import 'get_featured_products_usecase.dart';
import 'get_products_usecase.dart';

final getFeaturedProductsUseCaseProvider =
Provider<GetFeaturedProductsUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetFeaturedProductsUseCase(repository);
});


final getProductsUseCaseProvider =
Provider<GetProductsUseCase>((ref) {
  final repository = ref.watch(generalproductRepositoryProvider);
  return GetProductsUseCase(repository);
});
