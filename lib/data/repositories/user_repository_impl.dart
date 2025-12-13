import '../../domain/interfaces/repositories/user_repository.dart';
import '../../core/models/user.dart';
import '../../domain/interfaces/user_repository.dart';
import '../datasources/remote/user_remote_data_source.dart';
import '../datasources/local/user_local_data_source.dart';

/// Конкретная реализация UserRepository
/// Координирует работу удаленных и локальных источников данных
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;

  UserRepositoryImpl({
    required UserRemoteDataSource remoteDataSource,
    required UserLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  /// ==================== CRUD ОПЕРАЦИИ ====================

  @override
  Future<User> getUserById(String userId) async {
    try {
      // Пытаемся получить из сети (актуальные данные)
      final user = await _remoteDataSource.getUserById(userId);

      // Сохраняем в локальное хранилище для оффлайн-доступа
      await _localDataSource.saveUser(user);

      return user;
    } catch (networkError) {
      // Если сеть недоступна, используем локальные данные
      final localUser = await _localDataSource.getUserById(userId);

      if (localUser == null) {
        throw Exception('User not found and network unavailable');
      }

      return localUser;
    }
  }

  @override
  Future<User> getUserByEmail(String email) async {
    try {
      final user = await _remoteDataSource.getUserByEmail(email);
      await _localDataSource.saveUser(user);
      return user;
    } catch (networkError) {
      final localUser = await _localDataSource.getUserByEmail(email);

      if (localUser == null) {
        throw Exception('User not found and network unavailable');
      }

      return localUser;
    }
  }

  @override
  Future<User> createUser(User user) async {
    try {
      // Сначала сохраняем локально для мгновенного отклика UI
      await _localDataSource.saveUser(user);

      // Пытаемся создать на сервере
      final createdUser = await _remoteDataSource.createUser(user);

      // Обновляем локальные данные версией с сервера
      await _localDataSource.saveUser(createdUser);

      return createdUser;
    } catch (serverError) {
      // Если сервер недоступен, работаем локально
      // В реальном приложении можно добавить очередь синхронизации
      return user;
    }
  }

  @override
  Future<User> updateUser(User user) async {
    try {
      // Оптимистичное обновление: сразу обновляем локально
      await _localDataSource.saveUser(user);

      // Затем обновляем на сервере
      final updatedUser = await _remoteDataSource.updateUser(user);

      // Синхронизируем с локальным хранилищем
      await _localDataSource.saveUser(updatedUser);

      return updatedUser;
    } catch (serverError) {
      // Если сервер недоступен, возвращаем локальную версию
      return user;
    }
  }

  @override
  Future<bool> deleteUser(String userId) async {
    try {
      // Удаляем локально
      await _localDataSource.deleteUser(userId);

      // Удаляем на сервере
      await _remoteDataSource.deleteUser(userId);

      return true;
    } catch (serverError) {
      // Если сервер недоступен, всё равно удаляем локально
      // В реальном приложении можно добавить флаг "ожидает удаления"
      await _localDataSource.deleteUser(userId);
      return true;
    }
  }

  /// ==================== АУТЕНТИФИКАЦИЯ ====================

  @override
  Future<User> register(String email, String password, String name) async {
    try {
      // Регистрируемся на сервере
      final user = await _remoteDataSource.register(
        email: email,
        password: password,
        name: name,
      );

      // Сохраняем токен и пользователя локально
      await _localDataSource.saveUser(user);
      await _localDataSource.saveAuthToken(user.id, 'access_token_here');

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      // Авторизуемся на сервере
      final user = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      // Сохраняем данные локально
      await _localDataSource.saveUser(user);
      await _localDataSource.saveAuthToken(user.id, 'access_token_here');
      await _localDataSource.setCurrentUserId(user.id);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      // Пытаемся разлогиниться на сервере
      await _remoteDataSource.logout();
    } catch (e) {
      // Игнорируем ошибки сервера при логауте
    } finally {
      // Всегда очищаем локальные данные
      await _localDataSource.clearAuthData();
      await _localDataSource.clearCurrentUser();
    }

    return true;
  }

  @override
  Future<User?> getCurrentUser() async {
    // Получаем ID текущего пользователя из локального хранилища
    final currentUserId = await _localDataSource.getCurrentUserId();

    if (currentUserId == null) {
      return null;
    }

    try {
      // Пытаемся получить актуальные данные с сервера
      final user = await _remoteDataSource.getUserById(currentUserId);
      await _localDataSource.saveUser(user);
      return user;
    } catch (networkError) {
      // Используем локальную версию
      return await _localDataSource.getUserById(currentUserId);
    }
  }

  /// ==================== ВАЛИДАЦИЯ ====================

  @override
  Future<bool> emailExists(String email) async {
    try {
      // Проверяем на сервере
      return await _remoteDataSource.emailExists(email);
    } catch (networkError) {
      // Проверяем локально
      final localUser = await _localDataSource.getUserByEmail(email);
      return localUser != null;
    }
  }

  /// ==================== ПРОФИЛЬ ====================

  @override
  Future<User> updateProfile(User user) async {
    return await updateUser(user); // Используем общую логику обновления
  }

  @override
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      // Меняем пароль на сервере
      final success = await _remoteDataSource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      if (success) {
        // Очищаем локальные данные (нужно будет залогиниться заново)
        await _localDataSource.clearAuthData();
      }

      return success;
    } catch (e) {
      rethrow;
    }
  }
}