import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storelytech/app_router.dart';
import 'features/home/state/home_container.dart';
import 'features/profile/state/profile_container.dart';
import 'shared/app_theme.dart';
import 'features/auth/state/auth_container.dart';
import 'features/cart/state/cart_container.dart';
import 'features/favorites/state/favorites_container.dart';
import 'features/orders/state/orders_container.dart';
import 'features/settings/state/settings_container.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthContainer()),
        ChangeNotifierProvider(create: (_) => CartContainer()),
        ChangeNotifierProvider(create: (_) => HomeContainer()),
        ChangeNotifierProvider(create: (_) => FavoritesContainer()),
        ChangeNotifierProvider(create: (_) => OrdersContainer()),
        ChangeNotifierProvider(create: (_) => SettingsContainer()),
        ChangeNotifierProvider(
          create: (_) {
            final profileContainer = ProfileContainer();
            profileContainer.initializeWithSampleUser(); // Add this line
            return profileContainer;
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'StorelyTech',
        theme: AppTheme.lightTheme,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}