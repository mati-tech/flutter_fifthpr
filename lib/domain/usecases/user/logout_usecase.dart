import '../../interfaces/repositories/user_repository.dart';
// import '../interfaces/repositories/user_repository.dart';

/// UseCase для выхода из системы
class LogoutUseCase {
  final UserRepository _repository;

  LogoutUseCase(this._repository);

  /// Выполнить выход из системы
  ///
  /// Возвращает [true] если выход выполнен успешно
  Future<bool> execute() async {
    try {
      await _repository.logout();
      return true;
    } catch (e) {
      // Даже если произошла ошибка, считаем выход выполненным
      print('LogoutUseCase error: $e');
      return true;
    }
  }
}