import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storelytech/data/datasources/Remote/product_remote_datasource.dart';
import 'package:storelytech/data/repositories/product_repository_impl.dart';
// import '../datasources/remote/providers.dart';
// import '../datasources/remote/featured_product_datasource.dart';
// import '../datasources/remote/providers.dart';
import '../datasources/remote/providers.dart';
import 'general_product_repository_impl.dart';
// import 'general_product_repository_impl.dart';
// import 'general_product_repository_impl.dart';
// import 'remote/featured_product_datasource.dart';

final productRepositoryProvider = Provider<ProductRepositoryImpl>((ref) {
  // Получаем DataSource из другого провайдера
  final featuredRemoteDataSource = ref.watch(featuredProductRemoteDataSourceProvider);

  // Создаем Repository, передавая DataSource в конструктор
  return ProductRepositoryImpl(featuredRemoteDataSource);
});


final generalproductRepositoryProvider = Provider<GeneralProductRepositoryImpl>((ref) {
  // Получаем DataSource из другого провайдера
  final generalRemoteDataSource = ref.watch(generalProductRemoteDataSourceProvider);

  // Создаем Repository, передавая DataSource в конструктор
  return GeneralProductRepositoryImpl(generalRemoteDataSource);
});