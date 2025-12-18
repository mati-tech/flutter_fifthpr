// lib/domain/usecases/auth/login_usecase.dart
import '../../../core/models/user.dart';
import '../../interfaces/repositories/auth_repository.dart';
// import '../../entities/user.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  /// Login user with email and password.
  Future<User> execute({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || !email.contains('@')) {
      throw ArgumentError('Valid email is required');
    }
    if (password.isEmpty) {
      throw ArgumentError('Password is required');
    }

    return await repository.login(
      email: email,
      password: password,
    );
  }
}