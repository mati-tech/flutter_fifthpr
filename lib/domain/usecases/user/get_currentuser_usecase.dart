// lib/domain/usecases/auth/get_current_user_usecase.dart
import '../../../core/models/user.dart';
import '../../interfaces/repositories/auth_repository.dart';
// import '../../entities/user.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<User?> execute() async {
    return await repository.getCurrentUser();
  }
}