// // lib/data/datasources/local/shared_prefs_datasource.dart
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPrefsDataSource {
//   // Константы для ключей - централизованное управление
//   static const String _themeKey = 'storelytech_app_theme';
//   static const String _languageKey = 'storelytech_app_language';
//   static const String _notificationsKey = 'storelytech_notifications_enabled';
//   static const String _userIdKey = 'storelytech_user_id';
//   static const String _lastSyncKey = 'storelytech_last_sync';
//   static const String _currencyKey = 'storelytech_currency';
//   static const String _showPricesKey = 'storelytech_show_prices';
//
//   // Приватный метод для получения экземпляра
//   Future<SharedPreferences> _getPrefs() async {
//     return await SharedPreferences.getInstance();
//   }
//
//   // ========== ТЕМА ПРИЛОЖЕНИЯ ==========
//
//   Future<void> saveTheme(String theme) async {
//     final prefs = await _getPrefs();
//     await prefs.setString(_themeKey, theme);
//   }
//
//   Future<String> getTheme() async {
//     final prefs = await _getPrefs();
//     return prefs.getString(_themeKey) ?? 'light';
//   }
//
//   // ========== ЯЗЫК ИНТЕРФЕЙСА ==========
//
//   Future<void> saveLanguage(String language) async {
//     final prefs = await _getPrefs();
//     await prefs.setString(_languageKey, language);
//   }
//
//   Future<String> getLanguage() async {
//     final prefs = await _getPrefs();
//     return prefs.getString(_languageKey) ?? 'ru';
//   }
//
//   // ========== УВЕДОМЛЕНИЯ ==========
//
//   Future<void> setNotificationsEnabled(bool enabled) async {
//     final prefs = await _getPrefs();
//     await prefs.setBool(_notificationsKey, enabled);
//   }
//
//   Future<bool> getNotificationsEnabled() async {
//     final prefs = await _getPrefs();
//     return prefs.getBool(_notificationsKey) ?? true;
//   }
//
//   // ========== ПОЛЬЗОВАТЕЛЬ ==========
//
//   Future<void> saveUserId(String userId) async {
//     final prefs = await _getPrefs();
//     await prefs.setString(_userIdKey, userId);
//   }
//
//   Future<String?> getUserId() async {
//     final prefs = await _getPrefs();
//     return prefs.getString(_userIdKey);
//   }
//
//   // ========== НАСТРОЙКИ МАГАЗИНА ==========
//
//   Future<void> saveCurrency(String currency) async {
//     final prefs = await _getPrefs();
//     await prefs.setString(_currencyKey, currency);
//   }
//
//   Future<String> getCurrency() async {
//     final prefs = await _getPrefs();
//     return prefs.getString(_currencyKey) ?? 'USD';
//   }
//
//   Future<void> setShowPricesWithTax(bool showWithTax) async {
//     final prefs = await _getPrefs();
//     await prefs.setBool(_showPricesKey, showWithTax);
//   }
//
//   Future<bool> getShowPricesWithTax() async {
//     final prefs = await _getPrefs();
//     return prefs.getBool(_showPricesKey) ?? false;
//   }
//
//   // ========== СИНХРОНИЗАЦИЯ ==========
//
//   Future<void> saveLastSyncTimestamp() async {
//     final prefs = await _getPrefs();
//     final now = DateTime.now().millisecondsSinceEpoch;
//     await prefs.setInt(_lastSyncKey, now);
//   }
//
//   Future<DateTime?> getLastSyncTimestamp() async {
//     final prefs = await _getPrefs();
//     final timestamp = prefs.getInt(_lastSyncKey);
//
//     if (timestamp == null) return null;
//     return DateTime.fromMillisecondsSinceEpoch(timestamp);
//   }
//
//   // ========== УТИЛИТНЫЕ МЕТОДЫ ==========
//
//   Future<void> removeValue(String key) async {
//     final prefs = await _getPrefs();
//     await prefs.remove(key);
//   }
//
//   Future<void> clearAllSettings() async {
//     final prefs = await _getPrefs();
//     await prefs.clear();
//   }
//
//   Future<bool> containsKey(String key) async {
//     final prefs = await _getPrefs();
//     return prefs.containsKey(key);
//   }
//
//   // Получение всех настроек для отладки
//   Future<Map<String, dynamic>> getAllSettings() async {
//     final prefs = await _getPrefs();
//     final keys = prefs.getKeys();
//     final settings = <String, dynamic>{};
//
//     for (final key in keys) {
//       settings[key] = prefs.get(key);
//     }
//
//     return settings;
//   }
// }

// lib/data/datasources/local/shared_prefs_datasource.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsDataSource {
  static const String _themeKey = 'storelytech_app_theme';
  static const String _notificationsKey = 'storelytech_notifications_enabled';

  // ТЕМА ПРИЛОЖЕНИЯ (простая булевая - true = dark, false = light)
  Future<void> setDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }

  Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false;
  }

  // УВЕДОМЛЕНИЯ
  Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, enabled);
  }

  Future<bool> getNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsKey) ?? true;
  }
}