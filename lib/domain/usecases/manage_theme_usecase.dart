

// lib/domain/usecases/manage_theme_usecase.dart
import '../../data/datasources/local/shared_prefs_datasource.dart';

// Модель темы приложения
enum AppTheme {
  light,
  dark,
  system;

  String get name => toString().split('.').last;
}

class ManageThemeUseCase {
  final SharedPrefsDataSource _prefsDataSource;

  ManageThemeUseCase(this._prefsDataSource);

  // Сохранение темы
  Future<void> saveTheme(AppTheme theme) async {
    await _prefsDataSource.saveTheme(theme.name);
  }

  // Получение текущей темы
  Future<AppTheme> getCurrentTheme() async {
    final themeName = await _prefsDataSource.getTheme();

    switch (themeName) {
      case 'dark':
        return AppTheme.dark;
      case 'light':
        return AppTheme.light;
      case 'system':
        return AppTheme.system;
      default:
        return AppTheme.light; // Тема по умолчанию
    }
  }

  // Переключение между светлой и тёмной темой
  Future<AppTheme> toggleTheme() async {
    final currentTheme = await getCurrentTheme();
    final newTheme = currentTheme == AppTheme.light
        ? AppTheme.dark
        : AppTheme.light;

    await saveTheme(newTheme);
    return newTheme;
  }
}

















// // import '../../core/models/app_theme.dart';
// import '../../data/datasources/local/shared_prefs_datasource.dart';
//
// class ManageThemeUseCase {
//   final SharedPrefsDataSource _prefsDataSource;
//   ManageThemeUseCase(this._prefsDataSource);
//   // Сохранение выбранной темы
//   Future<void> saveTheme(AppTheme theme) async {
//     await _prefsDataSource.saveTheme(theme.name);
//   }
//   // Получение текущей темы
//   Future<AppTheme> getCurrentTheme() async {
//     final themeName = await _prefsDataSource.getTheme();
//     // Преобразование строки в enum
//     switch (themeName) {
//       case 'dark':
//         return AppTheme.dark;
//       case 'light':
//         return AppTheme.light;
//       case 'system':
//         return AppTheme.system;
//       default:
//         return AppTheme.light; // Тема по умолчанию
//     }
//   }
//   // Переключение между светлой и тёмной темой
//   Future<AppTheme> toggleTheme() async {
//     final currentTheme = await getCurrentTheme();
//     final newTheme = currentTheme == AppTheme.light
//         ? AppTheme.dark
//         : AppTheme.light;
//
//     await saveTheme(newTheme);
//     return newTheme;
//   }
// }
// enum AppTheme {
//   light,
//   dark,
//   system;
//
//   String get name => toString().split('.').last;
// }

