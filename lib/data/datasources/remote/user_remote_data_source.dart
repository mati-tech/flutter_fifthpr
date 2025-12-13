// lib/data/datasources/remote/user_remote_data_source_impl.dart
import '../../../core/models/user.dart';


/// Упрощенная реализация удаленного источника данных
/// Для учебного проекта без реального API
class UserRemoteDataSource {
  // Временное хранилище для демо
  final Map<String, User> _users = {};

  UserRemoteDataSourceImpl() {
    // Добавляем тестового пользователя
    _users['1'] = User.createDemoUser();
  }

  @override
  Future<User> getUserById(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Имитация задержки сети

    final user = _users[userId];
    if (user == null) {
      throw Exception('User not found');
    }

    return user;
  }

  @override
  Future<User> getUserByEmail(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final user = _users.values.firstWhere(
          (user) => user.email == email,
      orElse: () => throw Exception('User not found'),
    );

    return user;
  }

  @override
  Future<User> createUser(User user) async {
    await Future.delayed(const Duration(milliseconds: 500));

    _users[user.id] = user;
    return user;
  }

  @override
  Future<User> updateUser(User user) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (!_users.containsKey(user.id)) {
      throw Exception('User not found');
    }

    _users[user.id] = user;
    return user;
  }

  @override
  Future<bool> deleteUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (!_users.containsKey(userId)) {
      return false;
    }

    _users.remove(userId);
    return true;
  }

  @override
  Future<User> register(String email, String password, String name) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Простая валидация
    if (email.isEmpty || !email.contains('@')) {
      throw Exception('Invalid email');
    }

    if (password.length < 6) {
      throw Exception('Password too short');
    }

    // Проверяем, нет ли уже такого email
    final existingUser = _users.values.where((u) => u.email == email);
    if (existingUser.isNotEmpty) {
      throw Exception('Email already registered');
    }

    // Создаем нового пользователя
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _users[newUser.id] = newUser;
    return newUser;
  }

  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      final user = await getUserByEmail(email);

      // Простая проверка пароля (в реальном приложении - хеширование)
      if (password != '123456') { // Демо пароль
        throw Exception('Invalid password');
      }

      return user;
    } catch (e) {
      throw Exception('Invalid email or password');
    }
  }

  @override
  Future<bool> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true; // Всегда успешно
  }

  @override
  Future<bool> emailExists(String email) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      await getUserByEmail(email);
      return true; // Пользователь найден
    } catch (e) {
      return false; // Пользователь не найден
    }
  }

  @override
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (newPassword.length < 6) {
      throw Exception('New password too short');
    }

    return true;
  }
}