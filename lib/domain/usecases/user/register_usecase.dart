import '../../../core/models/user.dart';
// import '../../core/models/user.dart';
import '../../interfaces/user_repository.dart';
// import '../interfaces/repositories/user_repository.dart';

/// UseCase для регистрации нового пользователя
class RegisterUseCase {
  final UserRepository _repository;

  RegisterUseCase(this._repository);

  /// Зарегистрировать нового пользователя
  ///
  /// [email] - email пользователя
  /// [password] - пароль
  /// [name] - имя пользователя
  /// [phone] - телефон (опционально)
  /// [address] - адрес (опционально)
  ///
  /// Возвращает зарегистрированного пользователя
  ///
  /// Исключения:
  /// - [ArgumentError] если обязательные поля пустые
  /// - [Exception] если email уже занят или регистрация не удалась
  Future<User> execute({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? address,
  }) async {
    // Валидация обязательных полей
    if (email.isEmpty) {
      throw ArgumentError('Email cannot be empty');
    }

    if (password.isEmpty) {
      throw ArgumentError('Password cannot be empty');
    }

    if (name.isEmpty) {
      throw ArgumentError('Name cannot be empty');
    }

    // Проверка формата email
    if (!email.contains('@')) {
      throw ArgumentError('Invalid email format');
    }

    // Проверка длины пароля
    if (password.length < 6) {
      throw ArgumentError('Password must be at least 6 characters');
    }

    // Проверка, не занят ли email
    try {
      final emailExists = await _repository.emailExists(email);
      if (emailExists) {
        throw Exception('Email already registered');
      }
    } catch (e) {
      // Игнорируем ошибку проверки, продолжаем регистрацию
      print('Email check failed: $e');
    }

    try {
      // Регистрируем пользователя
      final user = await _repository.register(email, password, name);

      // Если есть дополнительные данные, обновляем профиль
      if (phone != null || address != null) {
        final updatedUser = user.copyWith(
          phone: phone,
          address: address,
        );
        return await _repository.updateProfile(updatedUser);
      }

      return user;
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }
}