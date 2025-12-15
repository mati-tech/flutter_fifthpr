// lib/domain/usecases/auth/logout_usecase.dart
import '../../interfaces/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> execute() async {
    await repository.logout();
  }
}