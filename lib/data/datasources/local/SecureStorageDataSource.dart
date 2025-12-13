// lib/data/datasources/local/secure_storage_datasource.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageDataSource {
  // Создание экземпляра с настройками
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    // Настройки для Android
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true, // Использовать EncryptedSharedPreferences
    ),
    // Настройки для iOS/macOS
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock, // Доступно после первого разблокирования
    ),
    // Настройки для Linux
    lOptions: const LinuxOptions(
      // Для Linux требуется установить libsecret
    ),
    // Настройки для Windows
    wOptions: const WindowsOptions(),
    // Настройки для Web
    webOptions: const WebOptions(
      // Для Web требуется настроить хранилище
    ),
  );

  // Ключи для хранения (рекомендуется использовать константы)
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _pinCodeKey = 'pin_code';
  static const String _biometricEnabledKey = 'biometric_enabled';
  static const String _emailKey = 'user_email';

  // ========== Токены аутентификации ==========


  // Сохранение access token
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }
// В SecureStorageDataSource добавьте:
  Future<void> saveTokenExpiry(Duration expiresIn) async {
    final expiryTime = DateTime.now().add(expiresIn);
    await _storage.write(
      key: 'token_expiry',
      value: expiryTime.millisecondsSinceEpoch.toString(),
    );
  }
  // Получение access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  // Сохранение refresh token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  // Получение refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // Удаление всех токенов (при выходе из системы)
  Future<void> clearAllTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  // ========== Данные пользователя ==========

  // Сохранение ID пользователя
  Future<void> saveUserId(String userId) async {
    await _storage.write(key: _userIdKey, value: userId);
  }

  // Получение ID пользователя
  Future<String?> getUserId() async {
    return await _storage.read(key: _userIdKey);
  }

  // Сохранение email пользователя
  Future<void> saveUserEmail(String email) async {
    await _storage.write(key: _emailKey, value: email);
  }

  // Получение email пользователя
  Future<String?> getUserEmail() async {
    return await _storage.read(key: _emailKey);
  }

  // ========== PIN-код ==========

  // Сохранение PIN-кода
  Future<void> savePinCode(String pinCode) async {
    await _storage.write(key: _pinCodeKey, value: pinCode);
  }

  // Получение PIN-кода
  Future<String?> getPinCode() async {
    return await _storage.read(key: _pinCodeKey);
  }

  // Проверка PIN-кода
  Future<bool> verifyPinCode(String inputPin) async {
    final savedPin = await _storage.read(key: _pinCodeKey);
    return savedPin == inputPin;
  }

  // Удаление PIN-кода
  Future<void> deletePinCode() async {
    await _storage.delete(key: _pinCodeKey);
  }

  // Проверка, установлен ли PIN-код
  Future<bool> hasPinCode() async {
    final pin = await _storage.read(key: _pinCodeKey);
    return pin != null && pin.isNotEmpty;
  }

  // ========== Биометрия ==========

  // Сохранение настройки биометрии
  Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(
      key: _biometricEnabledKey,
      value: enabled.toString(),
    );
  }

  // Проверка включена ли биометрия
  Future<bool> isBiometricEnabled() async {
    final value = await _storage.read(key: _biometricEnabledKey);
    return value == 'true';
  }

  // ========== Общие методы ==========

  // Проверка наличия сохранённых токенов
  Future<bool> hasTokens() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    return accessToken != null && refreshToken != null;
  }

  // Получение всех сохранённых значений (для отладки)
  Future<Map<String, String>> getAllValues() async {
    return await _storage.readAll();
  }

  // Удаление всех данных (полная очистка)
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Удаление конкретного значения по ключу
  Future<void> deleteByKey(String key) async {
    await _storage.delete(key: key);
  }

  // Проверка существования ключа
  Future<bool> containsKey(String key) async {
    final value = await _storage.read(key: key);
    return value != null;
  }
}