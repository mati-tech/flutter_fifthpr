
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storelytech/data/repositories/product_repository_impl.dart';
import '../datasources/Remote/providers.dart';

final productRepositoryProvider = Provider<ProductRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(featuredProductRemoteDataSourceProvider);
  return ProductRepositoryImpl(remoteDataSource);
});
