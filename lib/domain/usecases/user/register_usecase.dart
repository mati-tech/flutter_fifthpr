// lib/domain/usecases/auth/register_usecase.dart
import '../../../core/models/user.dart';
import '../../interfaces/repositories/auth_repository.dart';
// import '../../entities/user.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<User> execute({
    required String username,
    required String email,
    required String password,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
  }) async {
    // Validation
    if (username.isEmpty) throw ArgumentError('Username is required');
    if (email.isEmpty || !email.contains('@')) {
      throw ArgumentError('Valid email is required');
    }
    if (password.length < 6) {
      throw ArgumentError('Password must be at least 6 characters');
    }

    return await repository.register(
      username: username,
      email: email,
      password: password,
      phone: phone,
      address: address,
      dateOfBirth: dateOfBirth,
    );
  }
}