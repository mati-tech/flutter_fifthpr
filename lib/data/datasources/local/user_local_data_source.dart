// lib/data/datasources/local/user_local_data_source_impl.dart
// import 'dart:convert';
// // import 'package:shared_preferences/shared_preferences.dart';
// import '../../../core/models/user.dart';
// import 'user_local_data_source.dart';
//
// /// Упрощенная реализация локального хранилища
// class UserLocalDataSource {
//   // final SharedPreferences _prefs;
//
//   UserLocalDataSourceImpl(this._prefs);
//
//   // Ключи для SharedPreferences
//   static const String _userKey = 'current_user';
//   static const String _tokenKey = 'auth_token';
//
//   @override
//   Future<User?> getUserById(String userId) async {
//     // В упрощенной версии храним только текущего пользователя
//     final currentUser = await getCurrentUser();
//     if (currentUser != null && currentUser.id == userId) {
//       return currentUser;
//     }
//     return null;
//   }
//
//   @override
//   Future<User?> getUserByEmail(String email) async {
//     final currentUser = await getCurrentUser();
//     if (currentUser != null && currentUser.email == email) {
//       return currentUser;
//     }
//     return null;
//   }
//
//   @override
//   Future<void> saveUser(User user) async {
//     final userJson = jsonEncode(user.toJson());
//     await _prefs.setString(_userKey, userJson);
//   }
//
//   @override
//   Future<void> deleteUser(String userId) async {
//     final currentUser = await getCurrentUser();
//     if (currentUser != null && currentUser.id == userId) {
//       await clearAllData();
//     }
//   }
//
//   @override
//   Future<void> clearAllUsers() async {
//     await _prefs.remove(_userKey);
//   }
//
//   @override
//   Future<void> saveAuthToken(String userId, String token) async {
//     await _prefs.setString(_tokenKey, token);
//   }
//
//   @override
//   Future<String?> getAuthToken(String userId) async {
//     return _prefs.getString(_tokenKey);
//   }
//
//   @override
//   Future<void> clearAuthData() async {
//     await _prefs.remove(_tokenKey);
//   }
//
//   @override
//   Future<void> setCurrentUserId(String userId) async {
//     // Не нужно отдельно хранить ID, так как храним всего пользователя
//   }
//
//   @override
//   Future<String?> getCurrentUserId() async {
//     final user = await getCurrentUser();
//     return user?.id;
//   }
//
//   @override
//   Future<void> clearCurrentUser() async {
//     await _prefs.remove(_userKey);
//   }
//
//   @override
//   Future<bool> isDataAvailable() async {
//     final user = await getCurrentUser();
//     final token = _prefs.getString(_tokenKey);
//     return user != null && token != null;
//   }
//
//   @override
//   Future<void> clearAllData() async {
//     await _prefs.remove(_userKey);
//     await _prefs.remove(_tokenKey);
//   }
//
//   // Дополнительный метод для получения текущего пользователя
//   Future<User?> getCurrentUser() async {
//     final userJson = _prefs.getString(_userKey);
//     if (userJson == null) return null;
//
//     try {
//       final userMap = jsonDecode(userJson) as Map<String, dynamic>;
//       return User.fromJson(userMap);
//     } catch (e) {
//       await _prefs.remove(_userKey);
//       return null;
//     }
//   }
// }