import 'api/auth_api.dart';
// import 'auth_api.dart';
import 'dto/user_dto.dart';
// import 'dto/token_dto.dart';

class AuthApiDataSource {
  final AuthApi api;

  String? _token;

  // Call this after login to save token
  void setToken(String token) {
    _token = token;
  }

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

  // Future<TokenDto> login({
  //   required String username,
  //   required String password,
  // }) {
  //   async {
  //
  //   }
  //   _token = response.accessToken;
  //   return api.login(username, password);
  // }
  // Future<TokenDto> login({
  //   required String username,
  //   required String password,
  // }) async {
  //   final response = await api.login(
  //     // grant_type
  //     username,
  //     password,
  //   );
  //
  //   _token = response.accessToken; // Save token
  //   return response;
  // }
  //
  // Future<UserDto> getCurrentUser() {
  //   return api.getMe();
  // }
  // Future<UserDto> getCurrentUser() async {
  //   // Create a NEW Dio instance with the token
  //   final dio = Dio()
  //     ..options.baseUrl = 'http://127.0.0.1:8000'
  //     ..options.headers = {
  //       'Authorization': 'Bearer $_token',
  //     };
  //
  //   // Create new API instance with this Dio
  //   final authApiWithToken = AuthApi(dio);
  //   return await authApiWithToken.getCurrentUser();
  // }
}
