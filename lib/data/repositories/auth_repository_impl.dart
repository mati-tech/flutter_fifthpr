import '../../core/models/user.dart';
import '../../domain/interfaces/repositories/auth_repository.dart';
import '../datasources/Remote/auth_api_datasource.dart';
import '../datasources/Remote/mappers/user_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<User> register({
    required String username,
    required String email,
    required String password,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
  }) async {
    final userDto = await dataSource.register(
      username: username,
      email: email,
      password: password,
      phone: phone,
      address: address,
      dateOfBirth: dateOfBirth,
    );

    return UserMapper.toDomain(userDto);
  }

  @override
  Future<User> login({
    required String username,
    required String password,
  }) async {
    final tokenDto = await dataSource.login(
      username: username,
      password: password,
    );

    // optionally save token here
    // secureStorage.save(tokenDto.accessToken);

    final userDto = await dataSource.getCurrentUser();
    return UserMapper.toDomain(userDto);
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final userDto = await dataSource.getCurrentUser();
      return UserMapper.toDomain(userDto);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> changePassword({required String currentPassword, required String newPassword}) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<bool> isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<User> updateProfile({required String name, String? phone, String? address, DateTime? dateOfBirth, String? profileImageUrl}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<void> verifyEmail(String token) {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }
}
