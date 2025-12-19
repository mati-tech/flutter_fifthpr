// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:dio/dio.dart';
// import '../../../../core/network/api_client_provider.dart';
// import '../../../../data/datasources/remote/api/favorites_api.dart';
// import '../../../../data/datasources/remote/favorite_remote_datasource.dart';
// import '../../../../data/repositories/favorites_repository_impl.dart';
// import '../../../../domain/usecases/favorites/favorite_use_cases.dart';
// // import '../../data/datasources/remote/favorites_remote_data_source.dart';
// // import '../../data/datasources/remote/favorites_api.dart';
// // import '../../data/repositories/favorites_repository_impl.dart';
// // import '../../domain/usecases/favorites_usecases.dart';
//
// final favoritesApiProvider = Provider<FavoritesApi>((ref) {
//   final dio = ref.watch(apiClientProvider); // your Dio provider
//   return FavoritesApi(dio);
// });
//
// final favoritesRemoteDataSourceProvider =
// Provider<FavoritesRemoteDataSource>((ref) {
//   final api = ref.watch(favoritesApiProvider);
//   return FavoritesRemoteDataSource(api);
// });
//
// final favoritesRepositoryProvider = Provider<FavoritesRepositoryImpl>((ref) {
//   final remote = ref.watch(favoritesRemoteDataSourceProvider);
//   return FavoritesRepositoryImpl(remote);
// });
//
// // Use case providers
// final getFavoritesUseCaseProvider = Provider((ref) {
//   final repo = ref.watch(favoritesRepositoryProvider);
//   return GetFavoritesUseCase(repo);
// });
//
// final addFavoriteUseCaseProvider = Provider((ref) {
//   final repo = ref.watch(favoritesRepositoryProvider);
//   return AddFavoriteUseCase(repo);
// });
//
// final removeFavoriteUseCaseProvider = Provider((ref) {
//   final repo = ref.watch(favoritesRepositoryProvider);
//   return RemoveFavoriteUseCase(repo);
// });
