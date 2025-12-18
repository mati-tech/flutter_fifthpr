import 'api/auth_api.dart';
// import 'auth_api.dart';
import 'dto/user_dto.dart';
import 'dto/token_dto.dart';

class AuthApiDataSource {
  final AuthApi api;

  AuthApiDataSource(this.api);

  Future<UserDto> register({
    required String username,
    required String email,
    required String password,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
  }) {
    return api.register({
      "username": username,
      "email": email,
      "password": password,
    });
  }

  Future<TokenDto> login({
    required String username,
    required String password,
  }) {
    return api.login(username, password);
  }

  Future<UserDto> getCurrentUser() {
    return api.getMe();
  }
}
