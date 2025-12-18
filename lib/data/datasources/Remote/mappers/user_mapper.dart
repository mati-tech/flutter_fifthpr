import '../../../../core/models/user.dart';
// import '../../core/models/user.dart';
// import '../datasources/remote/dto/user_dto.dart';
import '../dto/user_dto.dart';




class UserMapper {
  static User toDomain(UserDto dto) {
    return User(
      id: dto.id,
      name: dto.username,
      email: dto.email,
      isActive: dto.is_active,

    );
  }
}
