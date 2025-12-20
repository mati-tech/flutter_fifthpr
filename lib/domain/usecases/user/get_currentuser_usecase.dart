// lib/domain/usecases/auth/get_current_user_usecase.dart
import '../../../core/models/user.dart';
import '../../interfaces/repositories/auth_repository.dart';
import '../../interfaces/repositories/product_repository.dart';
// import '../../entities/user.dart';


class GetUserByIdUseCase {
  // final GeneralProductRepository repository;
  final ProductRepository repository;
  GetUserByIdUseCase(this.repository);

  Future<User> execute(int id) async {
    return await repository.getUserDetail(id);
  }
}