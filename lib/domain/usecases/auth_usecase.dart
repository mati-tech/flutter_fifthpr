// // lib/domain/usecases/auth_usecase.dart
// import '../../data/datasources/local/SecureStorageDataSource.dart';
//
// class AuthUseCase {
//   final SecureStorageDataSource _secureStorage;
//
//   AuthUseCase(this._secureStorage);
//
//   // ========== СОХРАНЕНИЕ ДАННЫХ ==========
//
//   // Сохранение данных аутентификации
//   Future<void> saveAuthData(AuthData authData) async {
//     await _secureStorage.saveAccessToken(authData.accessToken);
//     await _secureStorage.saveRefreshToken(authData.refreshToken);
//     await _secureStorage.saveUserId(authData.userId);
//
//     if (authData.email != null && authData.email!.isNotEmpty) {
//       await _secureStorage.saveUserEmail(authData.email!);
//     }
//
//     if (authData.expiresIn != null) {
//       // Сохранение времени истечения токена
//       final expiryTime = DateTime.now().add(authData.expiresIn!);
//       // Сохраняем timestamp как строку
//       // Используем _storage напрямую или добавляем метод в SecureStorageDataSource
//       await _secureStorage.saveTokenExpiry(expiryTime as Duration);
//     }
//   }
//
//   // Сохранение данных при входе (упрощенный метод)
//   Future<void> login({
//     required String accessToken,
//     required String refreshToken,
//     required String userId,
//     String? email,
//     Duration? expiresIn,
//   }) async {
//     final authData = AuthData(
//       accessToken: accessToken,
//       refreshToken: refreshToken,
//       userId: userId,
//       email: email,
//       expiresIn: expiresIn,
//     );
//
//     await saveAuthData(authData);
//   }
//
//   // ========== ПОЛУЧЕНИЕ ДАННЫХ ==========
//
//   // Получение данных аутентификации
//   Future<AuthData?> getAuthData() async {
//     final accessToken = await _secureStorage.getAccessToken();
//     final refreshToken = await _secureStorage.getRefreshToken();
//     final userId = await _secureStorage.getUserId();
//     final email = await _secureStorage.getUserEmail();
//
//     if (accessToken == null || refreshToken == null) {
//       return null;
//     }
//
//     // // Получаем время истечения токена
//     // DateTime? tokenExpiry;
//     // final expiryString = await _secureStorage._storage.read(key: 'token_expiry');
//     // if (expiryString != null && expiryString.isNotEmpty) {
//     //   final expiryMillis = int.tryParse(expiryString);
//     //   if (expiryMillis != null) {
//     //     tokenExpiry = DateTime.fromMillisecondsSinceEpoch(expiryMillis);
//     //   }
//     // }
//     //
//     // return AuthData(
//     //   accessToken: accessToken,
//     //   refreshToken: refreshToken,
//     //   userId: userId ?? '',
//     //   email: email,
//     //   expiresIn: tokenExpiry != null
//     //       ? tokenExpiry.difference(DateTime.now())
//     //       : null,
//     // );
//   }
//
//   // ========== ПРОВЕРКИ ==========
//
//   // Проверка валидности токенов
//   Future<bool> isAuthenticated() async {
//     final authData = await getAuthData();
//     if (authData == null) {
//       return false;
//     }
//
//     // Проверка срока действия токена (если есть информация о времени)
//     if (authData.expiresIn != null) {
//       final isTokenExpired = authData.expiresIn!.isNegative;
//       if (isTokenExpired) {
//         // Токен истёк, можно попробовать обновить
//         return false;
//       }
//     }
//
//     return authData.accessToken.isNotEmpty && authData.refreshToken.isNotEmpty;
//   }
//
//   // Проверка, истёк ли токен
//   Future<bool> isTokenExpired() async {
//     final authData = await getAuthData();
//     if (authData == null || authData.expiresIn == null) {
//       return true; // Если нет данных, считаем токен недействительным
//     }
//
//     return authData.expiresIn!.isNegative;
//   }
//
//   // ========== ОПЕРАЦИИ ==========
//
//   // Выход из системы
//   Future<void> logout() async {
//     await _secureStorage.clearAllTokens();
//     await _secureStorage.deleteByKey('token_expiry');
//     // Очищаем email, но оставляем PIN-код и настройки биометрии
//     await _secureStorage.deleteByKey(SecureStorageDataSource._emailKey);
//   }
//
//   // Полный выход (с удалением всех пользовательских данных)
//   Future<void> fullLogout() async {
//     await _secureStorage.clearAll();
//   }
//
//   // Обновление access token
//   Future<void> updateAccessToken(String newToken, {Duration? newExpiresIn}) async {
//     await _secureStorage.saveAccessToken(newToken);
//
//     if (newExpiresIn != null) {
//       final expiryTime = DateTime.now().add(newExpiresIn);
//       await _secureStorage._storage.write(
//         key: 'token_expiry',
//         value: expiryTime.millisecondsSinceEpoch.toString(),
//       );
//     }
//   }
//
//   // Обновление refresh token
//   Future<void> updateRefreshToken(String newToken) async {
//     await _secureStorage.saveRefreshToken(newToken);
//   }
//
//   // ========== ДОПОЛНИТЕЛЬНЫЕ МЕТОДЫ ==========
//
//   // Получение только access token
//   Future<String?> getAccessToken() async {
//     return await _secureStorage.getAccessToken();
//   }
//
//   // Получение только refresh token
//   Future<String?> getRefreshToken() async {
//     return await _secureStorage.getRefreshToken();
//   }
//
//   // Получение ID пользователя
//   Future<String?> getUserId() async {
//     return await _secureStorage.getUserId();
//   }
//
//   // Получение email пользователя
//   Future<String?> getUserEmail() async {
//     return await _secureStorage.getUserEmail();
//   }
//
//   // Проверка, есть ли сохранённые учётные данные
//   Future<bool> hasSavedCredentials() async {
//     return await _secureStorage.hasTokens();
//   }
// }
//
// // ========== МОДЕЛЬ ДАННЫХ ==========
//
// // Модель данных аутентификации
// class AuthData {
//   final String accessToken;
//   final String refreshToken;
//   final String userId;
//   final String? email;
//   final Duration? expiresIn;
//
//   AuthData({
//     required this.accessToken,
//     required this.refreshToken,
//     required this.userId,
//     this.email,
//     this.expiresIn,
//   });
//
//   // Фабричный метод для создания из JSON
//   factory AuthData.fromJson(Map<String, dynamic> json) {
//     return AuthData(
//       accessToken: json['access_token'] ?? '',
//       refreshToken: json['refresh_token'] ?? '',
//       userId: json['user_id']?.toString() ?? '',
//       email: json['email'],
//       expiresIn: json['expires_in'] != null
//           ? Duration(seconds: json['expires_in'])
//           : null,
//     );
//   }
//
//   // Конвертация в JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'access_token': accessToken,
//       'refresh_token': refreshToken,
//       'user_id': userId,
//       'email': email,
//       'expires_in': expiresIn?.inSeconds,
//     };
//   }
//
//   @override
//   String toString() {
//     return 'AuthData(userId: $userId, email: $email, tokenExpiresIn: $expiresIn)';
//   }
// }