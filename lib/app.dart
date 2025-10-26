import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storelytech/features/auth/screens/register_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/home/screens/search_results_screen.dart';
import 'features/home/state/home_container.dart';
import 'features/profile/screens/edit_profile_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/profile/state/profile_container.dart';
import 'shared/app_theme.dart';
import 'features/auth/state/auth_container.dart';
import 'features/home/screens/home_screen.dart';
import 'features/cart/screens/cart_screen.dart';
import 'features/cart/state/cart_container.dart';
import 'features/favorites/screens/favorites_screen.dart';
import 'features/favorites/state/favorites_container.dart';
import 'features/orders/screens/orders_screen.dart';
import 'features/orders/screens/order_detail_screen.dart';
import 'features/orders/state/orders_container.dart';
import 'features/settings/screens/settings_screen.dart';
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
        ChangeNotifierProvider(create: (_) => ProfileContainer()),
      ],
      child: MaterialApp(
        title: 'StorelyTech',
        theme: AppTheme.lightTheme,
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => HomeScreen(),
          '/cart': (context) =>  CartScreen(),
          '/favorites': (context) =>  FavoritesScreen(),
          '/orders': (context) =>  OrdersScreen(),
          '/search': (context) => const SearchResultsScreen(),
          '/order-detail': (context) =>  OrderDetailScreen(),
          '/settings': (context) =>  SettingsScreen(),
          '/profile': (context) =>  ProfileScreen(),
          // '/edit-profile': (context) =>  EditProfileScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}