// lib/domain/interfaces/repositories/user_repository.dart
import '../../core/models/user.dart';

/// Базовый интерфейс репозитория для работы с пользователями
abstract class UserRepository {
  // Основные CRUD операции
  Future<User> getUserById(String userId);
  Future<User> getUserByEmail(String email);
  Future<User> createUser(User user);
  Future<User> updateUser(User user);
  Future<bool> deleteUser(String userId);

  // Аутентификация
  Future<User> register(String email, String password, String name);
  Future<User> login(String email, String password);
  Future<bool> logout();
  Future<User?> getCurrentUser();

  // Валидация
  Future<bool> emailExists(String email);

  // Профиль
  Future<User> updateProfile(User user);
  Future<bool> changePassword(String oldPassword, String newPassword);
}