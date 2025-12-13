import '../../../core/models/user.dart';
import '../../interfaces/user_repository.dart';


/// UseCase для входа в систему
class LoginUseCase {
  final UserRepository _repository;

  LoginUseCase(this._repository);

  /// Выполнить вход
  ///
  /// [email] - email пользователя
  /// [password] - пароль
  ///
  /// Возвращает авторизованного пользователя
  ///
  /// Исключения:
  /// - [ArgumentError] если email или пароль пустые
  /// - [Exception] если email или пароль неверные
  Future<User> execute({
    required String email,
    required String password,
  }) async {
    // Валидация входных данных
    if (email.isEmpty) {
      throw ArgumentError('Email cannot be empty');
    }

    if (password.isEmpty) {
      throw ArgumentError('Password cannot be empty');
    }

    // Проверка формата email
    if (!email.contains('@')) {
      throw ArgumentError('Invalid email format');
    }

    // Минимальная длина пароля
    if (password.length < 6) {
      throw ArgumentError('Password must be at least 6 characters');
    }

    try {
      // Выполняем логин через репозиторий
      final user = await _repository.login(email, password);
      return user;
    } catch (e) {
      // Преобразуем общую ошибку в понятное сообщение
      throw Exception('Login failed: Invalid email or password');
    }
  }
}