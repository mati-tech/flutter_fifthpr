import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../core/network/api_client_provider.dart';
import 'api/featured_product_api.dart';
import 'featured_product_datasource.dart';

final featuredProductApiProvider = Provider<FeaturedProductApi>((ref) {
  final dio = ref.watch(apiClientProvider);
  return FeaturedProductApi(dio);
});

final featuredProductRemoteDataSourceProvider =
Provider<FeaturedProductRemoteDataSource>((ref) {
  final api = ref.watch(featuredProductApiProvider);
  return FeaturedProductRemoteDataSource(api);
});
