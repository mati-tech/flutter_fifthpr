import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storelytech/data/datasources/remote/product2_remote_datasource.dart';
import '../../../core/network/api_client_provider.dart';
import 'api/product_api_2.dart';


final ProductApi2Provider = Provider<ProductApi2>((ref) {
  final dio = ref.watch(apiClientProvider);
  return ProductApi2(dio);
});

final Product2RemoteDataSourceProvider =
Provider<ProductRemote2Datasource>((ref) {
  final api1 = ref.watch(ProductApi2Provider);
  return ProductRemote2Datasource(api1);
});

// final generalProductApiProvider = Provider<ProductApi>((ref) {
//   final dio = ref.watch(apiClientProvider);
//   return ProductApi(dio);
// });
//
// final generalProductRemoteDataSourceProvider =
// Provider<ProductRemoteDataSource>((ref) {
//   final api2 = ref.watch(generalProductApiProvider);
//   return ProductRemoteDataSource(api2);
// });
