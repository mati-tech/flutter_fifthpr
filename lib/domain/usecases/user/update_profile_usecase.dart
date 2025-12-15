// lib/domain/usecases/auth/update_profile_usecase.dart
import '../../../core/models/user.dart';
import '../../interfaces/repositories/auth_repository.dart';
// import '../../entities/user.dart';

class UpdateProfileUseCase {
  final AuthRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<User> execute({
    required String name,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
    String? profileImageUrl,
  }) async {
    if (name.isEmpty) {
      throw ArgumentError('Name is required');
    }

    return await repository.updateProfile(
      name: name,
      phone: phone,
      address: address,
      dateOfBirth: dateOfBirth,
      profileImageUrl: profileImageUrl,
    );
  }
}