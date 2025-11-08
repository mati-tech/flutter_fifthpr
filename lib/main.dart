import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:storelytech/features/auth/auth_feature.dart';

import 'app.dart';
import 'core/setup_di.dart';
import 'features/auth/state/auth_container.dart';
import 'features/cart/state/cart_container.dart';
import 'features/favorites/state/favorites_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();


  final getIt = GetIt.I;

  // Пример получения объектов из контейнера

  // final auth = getIt<AuthContainer>(instanceName: "prof1"); // Singleton


  final mainCart = getIt<CartContainer>(instanceName: 'mainCart'); // Named instance
  final favorites1 = getIt<FavoritesContainer>(); // Factory — новый экземпляр каждый раз
  final favorites2 = getIt<FavoritesContainer>(); // Новый объект, отличный от favorites1



  final demoUser = User.createDemoUser();
  // auth.setUser(demoUser);
  // mainCart.addItem('Shoes');
  // favorites1.addToFavorites('Hat');
  // favorites2.addToFavorites('Socks');

  // print('Current user: ${auth.currentUser}'); // Пример вывода состояния
  //
  print(getIt.isRegistered<CartContainer>(instanceName: "mainCart"));
  // runApp(const App());
}
