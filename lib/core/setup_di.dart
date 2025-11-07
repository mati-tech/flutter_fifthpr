import 'package:get_it/get_it.dart';
import '../../features/auth/state/auth_container.dart';
import '../../features/cart/state/cart_container.dart';
import '../../features/favorites/state/favorites_container.dart';
import '../../features/home/state/home_container.dart';
import '../../features/orders/state/orders_container.dart';
import '../../features/profile/state/profile_container.dart';
import '../../features/settings/state/settings_container.dart';

final getIt = GetIt.instance;

/// Sets up dependency injection for the app
/// All containers are registered as singletons since they hold persistent state
Future<void> setupDI() async {
  // Register all containers as singletons
  // Using registerLazySingleton ensures they're only created when first accessed
  getIt.registerLazySingleton<AuthContainer>(() => AuthContainer());
  getIt.registerLazySingleton<CartContainer>(() => CartContainer());
  getIt.registerLazySingleton<FavoritesContainer>(() => FavoritesContainer());
  getIt.registerLazySingleton<HomeContainer>(() => HomeContainer());
  getIt.registerLazySingleton<OrdersContainer>(() => OrdersContainer());
  getIt.registerLazySingleton<SettingsContainer>(() => SettingsContainer());
  
  // ProfileContainer needs special initialization
  getIt.registerLazySingleton<ProfileContainer>(() {
    final profileContainer = ProfileContainer();
    profileContainer.initializeWithSampleUser();
    return profileContainer;
  });
}

