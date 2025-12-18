import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/token_dto.dart';
import '../dto/user_dto.dart';
// import 'dto/token_dto.dart';
// import 'dto/user_dto.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: 'http://127.0.0.1:8000')
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  /// 1️⃣ Registration
  @POST('/auth/register')
  Future<UserDto> register(
      @Body() Map<String, dynamic> body,
      );

  /// 2️⃣ Login (JWT)
  @POST('/auth/token')
  @FormUrlEncoded()
  Future<TokenDto> login(
      @Field('username') String username,
      @Field('password') String password,
      );

  /// 3️⃣ Get current user (JWT protected)
  @GET('/auth/me')
  Future<UserDto> getMe();
}
