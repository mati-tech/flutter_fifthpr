import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storelytech/data/datasources/remote/product_api_datasource.dart';

import '../../../core/network/api_client_provider.dart';
import 'api/featured_product_api.dart';
import 'api/product_api.dart';
import 'featured_product_datasource.dart';

final featuredProductApiProvider = Provider<FeaturedProductApi>((ref) {
  final dio = ref.watch(apiClientProvider);
  return FeaturedProductApi(dio);
});

final featuredProductRemoteDataSourceProvider =
Provider<FeaturedProductRemoteDataSource>((ref) {
  final api1 = ref.watch(featuredProductApiProvider);
  return FeaturedProductRemoteDataSource(api1);
});

final generalProductApiProvider = Provider<ProductApi>((ref) {
  final dio = ref.watch(apiClientProvider);
  return ProductApi(dio);
});

final generalProductRemoteDataSourceProvider =
Provider<ProductRemoteDataSource>((ref) {
  final api2 = ref.watch(generalProductApiProvider);
  return ProductRemoteDataSource(api2);
});
