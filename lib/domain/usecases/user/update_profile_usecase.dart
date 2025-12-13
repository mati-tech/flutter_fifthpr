import '../../../core/models/user.dart';
// import '../../core/models/user.dart';
import '../../interfaces/user_repository.dart';
// import '../interfaces/repositories/user_repository.dart';

/// UseCase для обновления профиля пользователя
class UpdateProfileUseCase {
  final UserRepository _repository;

  UpdateProfileUseCase(this._repository);

  /// Обновить профиль текущего пользователя
  ///
  /// [updates] - карта обновлений (только изменяемые поля)
  ///
  /// Возвращает обновленного пользователя
  ///
  /// Исключения:
  /// - [ArgumentError] если нет текущего пользователя
  /// - [Exception] если обновление не удалось
  Future<User> execute(Map<String, dynamic> updates) async {
    // Получаем текущего пользователя
    final currentUser = await _repository.getCurrentUser();

    if (currentUser == null) {
      throw ArgumentError('No current user found');
    }

    // Валидация обновлений
    if (updates.containsKey('email')) {
      final newEmail = updates['email'] as String;
      if (newEmail.isEmpty || !newEmail.contains('@')) {
        throw ArgumentError('Invalid email format');
      }

      // Проверяем, не занят ли новый email другим пользователем
      if (newEmail != currentUser.email) {
        try {
          final emailExists = await _repository.emailExists(newEmail);
          if (emailExists) {
            throw Exception('Email already registered');
          }
        } catch (e) {
          // Продолжаем, даже если проверка не удалась
        }
      }
    }

    if (updates.containsKey('name')) {
      final newName = updates['name'] as String;
      if (newName.isEmpty) {
        throw ArgumentError('Name cannot be empty');
      }
    }

    // Создаем обновленного пользователя
    final updatedUser = currentUser.copyWith(
      id: currentUser.id,
      email: updates['email'] as String? ?? currentUser.email,
      name: updates['name'] as String? ?? currentUser.name,
      phone: updates['phone'] as String? ?? currentUser.phone,
      address: updates['address'] as String? ?? currentUser.address,
      dateOfBirth: updates['dateOfBirth'] as DateTime? ?? currentUser.dateOfBirth,
      profileImageUrl: updates['profileImageUrl'] as String? ?? currentUser.profileImageUrl,
      createdAt: currentUser.createdAt,
      updatedAt: DateTime.now(),
    );

    try {
      // Сохраняем обновления
      final result = await _repository.updateProfile(updatedUser);
      return result;
    } catch (e) {
      throw Exception('Profile update failed: ${e.toString()}');
    }
  }

  /// Упрощенный метод для обновления конкретных полей
  Future<User> update({
    String? name,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
    String? profileImageUrl,
  }) async {
    final updates = <String, dynamic>{};

    if (name != null) updates['name'] = name;
    if (phone != null) updates['phone'] = phone;
    if (address != null) updates['address'] = address;
    if (dateOfBirth != null) updates['dateOfBirth'] = dateOfBirth;
    if (profileImageUrl != null) updates['profileImageUrl'] = profileImageUrl;

    return execute(updates);
  }
}