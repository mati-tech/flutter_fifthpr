import '../../../../core/models/user.dart';
import '../dto/user_dto.dart';


extension UserMapper on UserDto {
  User toDomain() { // НЕ статический
    return User(
      id: id,
      email: email,
      username: username,
      password: password,
      firstname: name['firstname'] as String,
      lastname: name['lastname'] as String,
      phone: phone,
    );
  }
}