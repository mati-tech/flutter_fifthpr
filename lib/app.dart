import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/screens/login_screen.dart';
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
        ChangeNotifierProvider(create: (_) => FavoritesContainer()),
        ChangeNotifierProvider(create: (_) => OrdersContainer()),
        ChangeNotifierProvider(create: (_) => SettingsContainer()),
      ],
      child: MaterialApp(
        title: 'StorelyTech',
        theme: AppTheme.lightTheme,
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/cart': (context) =>  CartScreen(),
          '/favorites': (context) =>  FavoritesScreen(),
          '/orders': (context) =>  OrdersScreen(),
          '/order-detail': (context) =>  OrderDetailScreen(),
          '/settings': (context) =>  SettingsScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}