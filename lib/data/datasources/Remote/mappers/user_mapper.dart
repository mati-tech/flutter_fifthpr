// lib/data/mappers/user_mapper.dart
import '../../../../core/models/user.dart';
import '../dto/user_dto.dart';

class UserMapper {
  static User toDomain(UserDto dto) {
    final now = DateTime.now();
    return User(
      id: dto.id,
      email: dto.email,
      // Map FastAPI username → existing `name` field
      name: dto.username,
      phone: dto.phone,
      address: dto.address,
      dateOfBirth: dto.dateOfBirth != null
          ? DateTime.tryParse(dto.dateOfBirth!)
          : null,
      profileImageUrl: dto.profileImageUrl,
      createdAt: dto.createdAt != null
          ? DateTime.tryParse(dto.createdAt!) ?? now
          : now,
      updatedAt: dto.updatedAt != null
          ? DateTime.tryParse(dto.updatedAt!) ?? now
          : now,
    );
  }

  static UserDto toDto(User user) {
    return UserDto(
      id: user.id,
      username: user.name,
      email: user.email,
      isActive: true,
      name: user.name,
      phone: user.phone,
      address: user.address,
      dateOfBirth: user.dateOfBirth?.toIso8601String(),
      profileImageUrl: user.profileImageUrl,
      createdAt: user.createdAt.toIso8601String(),
      updatedAt: user.updatedAt.toIso8601String(),
    );
  }
}