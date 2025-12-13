// lib/data/datasources/local/shared_prefs_datasource.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsDataSource {
  // Константы для ключей хранения — централизованное управление ключами
  static const String _themeKey = 'app_theme';
  static const String _userIdKey = 'user_id';
  static const String _notificationsKey = 'notifications_enabled';
  static const String _lastSyncKey = 'last_sync_timestamp';
  static const String _userSettingsKey = 'user_settings';


  // Приватный метод для получения экземпляра SharedPreferences
  // Используется во всех публичных методах
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }


  // Пример сохранения строкового значения (тема приложения)
  Future<void> saveTheme(String themeName) async {
    final prefs = await _getPrefs();
    await prefs.setString(_themeKey, themeName);
  }

  // Пример получения строкового значения с значением по умолчанию
  Future<String> getTheme() async {
    final prefs = await _getPrefs();
    return prefs.getString(_themeKey) ?? 'light'; // Значение по умолчанию
  }

  // Пример сохранения целочисленного значения (ID пользователя)
  Future<void> saveUserId(int userId) async {
    final prefs = await _getPrefs();
    await prefs.setInt(_userIdKey, userId);
  }

  // Пример получения целочисленного значения
  Future<int?> getUserId() async {
    final prefs = await _getPrefs();
    return prefs.getInt(_userIdKey); // Может вернуть null, если значение не сохранено
  }

  // Пример сохранения булевого значения (включены ли уведомления)
  Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_notificationsKey, enabled);
  }

  // Пример получения булевого значения с значением по умолчанию
  Future<bool> getNotificationsEnabled() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_notificationsKey) ?? true; // По умолчанию включены
  }

  // Пример сохранения списка строк (например, избранные элементы)
  Future<void> saveFavoriteItems(List<String> items) async {
    final prefs = await _getPrefs();
    await prefs.setStringList(_userSettingsKey, items);
  }

  // Пример получения списка строк
  Future<List<String>> getFavoriteItems() async {
    final prefs = await _getPrefs();
    return prefs.getStringList(_userSettingsKey) ?? []; // Пустой список по умолчанию
  }

  // Пример сохранения временной метки (timestamp)
  Future<void> saveLastSyncTimestamp() async {
    final prefs = await _getPrefs();
    final now = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt(_lastSyncKey, now);
  }

  // Пример получения временной метки с проверкой срока действия
  Future<DateTime?> getLastSyncTimestamp() async {
    final prefs = await _getPrefs();
    final timestamp = prefs.getInt(_lastSyncKey);

    if (timestamp == null) {
      return null;
    }

    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  // Удаление конкретного значения по ключу
  Future<void> removeValue(String key) async {
    final prefs = await _getPrefs();
    await prefs.remove(key);
  }

  // Очистка всех сохранённых данных (осторожно!)
  Future<void> clearAll() async {
    final prefs = await _getPrefs();
    await prefs.clear();
  }

  // Проверка существования значения по ключу
  Future<bool> containsKey(String key) async {
    final prefs = await _getPrefs();
    return prefs.containsKey(key);
  }
}