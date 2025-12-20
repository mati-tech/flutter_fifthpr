// lib/domain/usecases/auth/delete_account_usecase.dart
import '../../../core/models/user.dart';
import '../../interfaces/repositories/auth_repository.dart';
import '../../interfaces/repositories/product_repository.dart';


class DeleteUserByIdUseCase {
  // final GeneralProductRepository repository;
  final ProductRepository repository;
  DeleteUserByIdUseCase(this.repository);

  Future<User> execute(int id) async {
    return await repository.deleteUser(id);
  }
}