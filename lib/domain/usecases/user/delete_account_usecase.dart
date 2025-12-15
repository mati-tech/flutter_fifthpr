// lib/domain/usecases/auth/delete_account_usecase.dart
import '../../interfaces/repositories/auth_repository.dart';

class DeleteAccountUseCase {
  final AuthRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<void> execute() async {
    // Add confirmation logic if needed
    await repository.deleteAccount();
  }
}