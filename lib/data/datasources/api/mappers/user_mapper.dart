// lib/data/mappers/user_mapper.dart
import '../../../../core/models/user.dart';
// import '../../domain/entities/user.dart';
import '../dto/user_dto.dart';
// import '../dtos/user_dto.dart';

class UserMapper {
  static User toDomain(UserDto dto) {
    return User(
      id: dto.id,
      email: dto.email,
      name: dto.name,
      phone: dto.phone,
      address: dto.address,
      dateOfBirth: dto.dateOfBirth != null
          ? DateTime.tryParse(dto.dateOfBirth!)
          : null,
      profileImageUrl: dto.profileImageUrl,
      createdAt: DateTime.parse(dto.createdAt),
      updatedAt: DateTime.parse(dto.updatedAt),
    );
  }

  static UserDto toDto(User user) {
    return UserDto(
      id: user.id,
      email: user.email,
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