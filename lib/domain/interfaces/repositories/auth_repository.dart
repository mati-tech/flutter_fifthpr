// lib/domain/interfaces/repositories/auth_repository.dart
import '../../../core/models/user.dart';
// import '../entities/user.dart';

abstract class AuthRepository {
  // Registration
  Future<User> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
  });

  // Login
  Future<User> login({
    required String email,
    required String password,
  });

  // Logout
  Future<void> logout();

  // Get current user
  Future<User?> getCurrentUser();

  // Check if user is logged in
  Future<bool> isLoggedIn();

  // Update profile
  Future<User> updateProfile({
    required String name,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
    String? profileImageUrl,
  });

  // Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  // Forgot password
  Future<void> forgotPassword(String email);

  // Verify email
  Future<void> verifyEmail(String token);

  // Delete account
  Future<void> deleteAccount();
}