
import 'package:go_router/go_router.dart';
import 'package:storelytech/ui/features/auth/screens/login_screen.dart';
import 'package:storelytech/ui/features/auth/screens/register_screen.dart';
import 'package:storelytech/ui/features/cart/screens/cart_screen.dart';
import 'package:storelytech/ui/features/favorites/screens/favorites_screen.dart';
import 'package:storelytech/ui/features/home/screens/home_screen.dart';
import 'package:storelytech/ui/features/home/screens/product_detail_screen.dart';
import 'package:storelytech/ui/features/home/screens/search_results_screen.dart';
import 'package:storelytech/ui/features/orders/screens/orders_screen.dart';
import 'package:storelytech/ui/features/profile/screens/edit_profile_screen.dart';
import 'package:storelytech/ui/features/profile/screens/profile_screen.dart';
import 'package:storelytech/ui/features/settings/screens/settings_screen.dart';

import 'core/models/product.dart';
// import 'features/auth/screens/login_screen.dart';
// import 'features/auth/screens/register_screen.dart';
//
// import 'features/cart/screens/cart_screen.dart';
// import 'features/favorites/screens/favorites_screen.dart';
// import 'features/home/models/product.dart';
// import 'features/home/screens/home_screen.dart';
// import 'features/home/screens/product_detail_screen.dart';
// import 'features/home/screens/search_results_screen.dart';
//
// import 'features/orders/screens/order_detail_screen.dart';
// import 'features/orders/screens/orders_screen.dart';
// import 'features/profile/screens/edit_profile_screen.dart';
// import 'features/profile/screens/profile_screen.dart';
// import 'features/settings/screens/settings_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    // GoRoute(
    //   path: '/cart',
    //   builder: (context, state) => const CartScreen(),
    // ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) =>  FavoritesScreen(),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchResultsScreen(),
    ),
    // GoRoute(
    //   path: '/settings',
    //   builder: (context, state) => const SettingsScreen(),
    // ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    // GoRoute(
    //   path: '/order-detail/:orderId',
    //   builder: (context, state) {
    //     final orderId = state.pathParameters['orderId']!;
    //     return OrderDetailScreen(orderId: orderId);
    //   },
    // ),
    // GoRoute(
    //   path: '/product_detail',
    //   builder: (context, state) {
    //     final product = state.extra as Product; // Получаем весь объект
    //     // return ProductDetailScreen(product: product);
    //   },
    // ),
    // GoRoute(
    //   path: '/',
    //   redirect: (context, state) => '/login',
    // ),
  ],
);