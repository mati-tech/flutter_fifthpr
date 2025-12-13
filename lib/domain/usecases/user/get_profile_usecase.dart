import '../../../core/models/user.dart';

import '../../interfaces/user_repository.dart';

/// UseCase для получения профиля текущего пользователя
class GetProfileUseCase {
  final UserRepository _repository;

  GetProfileUseCase(this._repository);

  /// Получить профиль текущего пользователя
  ///
  /// Возвращает [User] или null, если пользователь не авторизован
  Future<User?> execute() async {
    try {
      return await _repository.getCurrentUser();
    } catch (e) {
      // Логируем ошибку, но не выбрасываем дальше
      print('GetProfileUseCase error: $e');
      return null;
    }
  }
}