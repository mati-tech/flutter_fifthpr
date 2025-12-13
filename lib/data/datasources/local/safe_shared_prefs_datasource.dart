




// lib/data/datasources/local/safe_shared_prefs_datasource.dart
import 'shared_prefs_datasource.dart';

class SafeSharedPrefsDataSource {
  final SharedPrefsDataSource _dataSource;

  SafeSharedPrefsDataSource(this._dataSource);

  Future<String> getThemeSafe() async {
    try {
      return await _dataSource.getTheme();
    } catch (e) {
      print('Ошибка при получении темы: $e');
      return 'light'; // Значение по умолчанию
    }
  }

  Future<void> saveThemeSafe(String theme) async {
    try {
      await _dataSource.saveTheme(theme);
    } catch (e) {
      print('Ошибка при сохранении темы: $e');
      // Не бросаем исключение дальше
    }
  }

  Future<bool> getNotificationsEnabledSafe() async {
    try {
      return await _dataSource.getNotificationsEnabled();
    } catch (e) {
      print('Ошибка при получении настроек уведомлений: $e');
      return true; // По умолчанию включены
    }
  }

  Future<void> setNotificationsEnabledSafe(bool enabled) async {
    try {
      await _dataSource.setNotificationsEnabled(enabled);
    } catch (e) {
      print('Ошибка при сохранении настроек уведомлений: $e');
    }
  }

  // Future<String> getLanguageSafe() async {
  //   try {
  //     return await _dataSource.getLanguage();
  //   } catch (e) {
  //     print('Ошибка при получении языка: $e');
  //     return 'ru'; // Значение по умолчанию
  //   }
  // }
  //
  // Future<void> saveLanguageSafe(String language) async {
  //   try {
  //     await _dataSource.saveLanguage(language);
  //   } catch (e) {
  //     print('Ошибка при сохранении языка: $e');
  //   }
  // }
}









// // lib/data/datasources/local/safe_shared_prefs_datasource.dart
// import 'shared_prefs_datasource.dart';
//
// class SafeSharedPrefsDataSource {
//   final SharedPrefsDataSource _dataSource;
//
//   SafeSharedPrefsDataSource(this._dataSource);
//
//   Future<String> getThemeSafe() async {
//     try {
//       return await _dataSource.getTheme();
//     } catch (e) {
//       // Логирование ошибки и возврат значения по умолчанию
//       print('Ошибка при получении темы: $e');
//       return 'light'; // Значение по умолчанию при ошибке
//     }
//   }
//
//   Future<void> saveThemeSafe(String theme) async {
//     try {
//       await _dataSource.saveTheme(theme);
//     } catch (e) {
//       // Логирование ошибки, но не пробрасывание исключения выше
//       // чтобы не прерывать работу пользователя
//       print('Ошибка при сохранении темы: $e');
//       // Можно добавить дополнительную логику:
//       // - Отправку ошибки в аналитику
//       // - Показать уведомление пользователю (в production)
//     }
//   }
//
//   // Безопасное получение ID пользователя
//   Future<int?> getUserIdSafe() async {
//     try {
//       return await _dataSource.getUserId();
//     } catch (e) {
//       print('Ошибка при получении ID пользователя: $e');
//       return null;
//     }
//   }
//
//   // Безопасное сохранение ID пользователя
//   Future<void> saveUserIdSafe(int userId) async {
//     try {
//       await _dataSource.saveUserId(userId);
//     } catch (e) {
//       print('Ошибка при сохранении ID пользователя: $e');
//     }
//   }
//
//   // Безопасное получение настроек уведомлений
//   Future<bool> getNotificationsEnabledSafe() async {
//     try {
//       return await _dataSource.getNotificationsEnabled();
//     } catch (e) {
//       print('Ошибка при получении настроек уведомлений: $e');
//       return true; // По умолчанию включены
//     }
//   }
//
//   // Безопасное сохранение настроек уведомлений
//   Future<void> setNotificationsEnabledSafe(bool enabled) async {
//     try {
//       await _dataSource.setNotificationsEnabled(enabled);
//     } catch (e) {
//       print('Ошибка при сохранении настроек уведомлений: $e');
//     }
//   }
//
//   // Безопасное получение избранных элементов
//   Future<List<String>> getFavoriteItemsSafe() async {
//     try {
//       return await _dataSource.getFavoriteItems();
//     } catch (e) {
//       print('Ошибка при получении избранных элементов: $e');
//       return []; // Пустой список по умолчанию
//     }
//   }
//
//   // Безопасное сохранение избранных элементов
//   Future<void> saveFavoriteItemsSafe(List<String> items) async {
//     try {
//       await _dataSource.saveFavoriteItems(items);
//     } catch (e) {
//       print('Ошибка при сохранении избранных элементов: $e');
//     }
//   }
//
//   // Безопасное удаление значения
//   Future<void> removeValueSafe(String key) async {
//     try {
//       await _dataSource.removeValue(key);
//     } catch (e) {
//       print('Ошибка при удалении значения: $e');
//     }
//   }
//
//   // Безопасная очистка всех данных
//   Future<void> clearAllSafe() async {
//     try {
//       await _dataSource.clearAll();
//     } catch (e) {
//       print('Ошибка при очистке данных: $e');
//     }
//   }
// }




