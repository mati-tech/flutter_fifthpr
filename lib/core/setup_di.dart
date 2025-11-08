import 'package:get_it/get_it.dart';
import '../../features/auth/state/auth_container.dart';
import '../../features/cart/state/cart_container.dart';
import '../../features/favorites/state/favorites_container.dart';
import '../../features/home/state/home_container.dart';
import '../../features/orders/state/orders_container.dart';
import '../../features/profile/state/profile_container.dart';
import '../../features/settings/state/settings_container.dart';

final getIt = GetIt.instance;
Future<void> setupDI() async {
  getIt.registerLazySingleton<AuthContainer>(() => AuthContainer());
  getIt.registerLazySingleton<CartContainer>(() => CartContainer());
  getIt.registerLazySingleton<FavoritesContainer>(() => FavoritesContainer());
  getIt.registerLazySingleton<HomeContainer>(() => HomeContainer());
  getIt.registerLazySingleton<OrdersContainer>(() => OrdersContainer());
  getIt.registerLazySingleton<SettingsContainer>(() => SettingsContainer());
  getIt.registerFactory<FavoritesContainer>(() => FavoritesContainer());
  getIt.registerLazySingleton<ProfileContainer>(() {
    final profileContainer = ProfileContainer();
    profileContainer.initializeWithSampleUser();
    return profileContainer;
  });
  // getIt.allowReassignment = true;
}

