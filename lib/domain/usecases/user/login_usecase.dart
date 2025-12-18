// lib/domain/usecases/auth/login_usecase.dart
import '../../../core/models/user.dart';
import '../../interfaces/repositories/auth_repository.dart';
// import '../../entities/user.dart';


class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> execute(String username, String password) {
    return repository.login(username: username, password: password);
  }
}
