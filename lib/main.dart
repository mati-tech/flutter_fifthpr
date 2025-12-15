import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storelytech/ui/features/settings/providers/settings_provider.dart';
import 'package:storelytech/ui/shared/app_theme.dart';
import 'app.dart';
import 'app_router.dart';
// import 'features/settings/providers/settings_provider.dart';
// import 'shared/setup_di.dart';

// void main() {
//   runApp(
//     const ProviderScope(
//       child: App(),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import './providers/settings_notifier.dart';
// import './shared/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Слушаем изменения темы
    // final settings = ref.watch(settingsNotifierProvider);

    return MaterialApp.router(
      title: 'StorelyTech',
      // Ключевой момент: обновляем тему на основе состояния
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      // Выбираем режим темы на основе isDarkMode
      // themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: router, // Ваш роутер
      debugShowCheckedModeBanner: false,
    );
  }

  // Светлая тема
  ThemeData _buildLightTheme() {
    return ThemeData(
      primaryColor: AppTheme.primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppTheme.primaryColor,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  // Темная тема
  ThemeData _buildDarkTheme() {
    return ThemeData(
      primaryColor: AppTheme.primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppTheme.primaryColor,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
    );
  }
}
