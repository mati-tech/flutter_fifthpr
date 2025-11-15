import 'package:flutter/foundation.dart';
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

  runApp(const App());
}
