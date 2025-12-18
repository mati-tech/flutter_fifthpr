// lib/data/repositories/auth_repository_impl.dart
import '../../core/models/user.dart';
import '../../domain/interfaces/repositories/auth_repository.dart';
// import '../../domain/entities/user.dart';
import '../datasources/Remote/auth_api_datasource.dart';
import '../datasources/Remote/dto/user_dto.dart';
import '../datasources/Remote/mappers/user_mapper.dart';
// import '../datasources/auth_api_datasource.dart';
// import '../mappers/user_mapper.dart';

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
    final response = await dataSource.register(
      username: username,
      email: email,
      password: password,
      phone: phone,
      address: address,
      dateOfBirth: dateOfBirth,
    );

    return UserMapper.toDomain(UserDto.fromJson(response));
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final response = await dataSource.login(
      email: email,
      password: password,
    );

    return UserMapper.toDomain(UserDto.fromJson(response));
  }

  @override
  Future<void> logout() async {
    await dataSource.logout();
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final response = await dataSource.getCurrentUser();
      return UserMapper.toDomain(UserDto.fromJson(response));
    } catch (e) {
      return null; // Not logged in
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }

  @override
  Future<User> updateProfile({
    required String name,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
    String? profileImageUrl,
  }) async {
    final response = await dataSource.updateProfile(
      name: name,
      phone: phone,
      address: address,
      dateOfBirth: dateOfBirth,
      profileImageUrl: profileImageUrl,
    );

    return UserMapper.toDomain(UserDto.fromJson(response));
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await dataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> forgotPassword(String email) async {
    await dataSource.forgotPassword(email);
  }

  @override
  Future<void> verifyEmail(String token) async {
    await dataSource.verifyEmail(token);
  }

  @override
  Future<void> deleteAccount() async {
    // For mock, just logout
    await logout();
  }
}