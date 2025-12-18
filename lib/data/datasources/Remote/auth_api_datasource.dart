// lib/data/datasources/Remote/auth_api_datasource.dart

import 'package:dio/dio.dart';
import '../../../core/config/env.dart';
import '../../../core/network/api_client.dart';

abstract class AuthApiDataSource {
  // Register new user
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
  });

  // Login existing user
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });

  // Logout user
  Future<void> logout();

  // Get current authenticated user
  Future<Map<String, dynamic>> getCurrentUser();

  // Check if user is authenticated
  Future<bool> isAuthenticated();

  // Update user profile
  Future<Map<String, dynamic>> updateProfile({
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

  // Request password reset
  Future<void> forgotPassword(String email);

  // Verify email with token
  Future<void> verifyEmail(String token);

  // Refresh authentication token
  Future<Map<String, dynamic>> refreshToken(String refreshToken);

  // Upload profile image
  Future<String> uploadProfileImage(String imagePath);

  // Delete user account
  Future<void> deleteAccount();

  // Social login (optional)
  Future<Map<String, dynamic>> socialLogin({
    required String provider, // 'google', 'facebook', 'apple'
    required String token,
  });

  // Link social account
  Future<void> linkSocialAccount({
    required String provider,
    required String token,
  });

  // Unlink social account
  Future<void> unlinkSocialAccount(String provider);
}

/// FastAPI-backed implementation using Dio
class FastApiAuthApiDataSource implements AuthApiDataSource {
  final ApiClient _client;

  FastApiAuthApiDataSource(this._client);

  Dio get _dio => _client.dio;

  @override
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
  }) async {
    print('=== DEBUG REGISTER REQUEST ===');
    print('Received name parameter: "$name"');
    print('Will send to API as username: "$name"');
    print('Email: "$email"');
    print('Password length: ${password.length}');

    try {
      final response = await _dio.post(
        '/auth/register',
        data: {
          'username': name,
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print('=== DEBUG REGISTER RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Response: ${response.data}');

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      print('=== DEBUG REGISTER ERROR ===');
      print('Error type: ${e.type}');
      print('Error message: ${e.message}');
      print('Response data: ${e.response?.data}');
      print('Response status: ${e.response?.statusCode}');
      rethrow;
    } catch (e) {
      print('=== DEBUG OTHER ERROR ===');
      print('Error: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    // FastAPI expects form data: username, password, grant_type
    final response = await _dio.post(
      '/auth/token',
      data: {
        'username': email,
        'password': password,
        'grant_type': 'password',
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    final data = response.data as Map<String, dynamic>;
    final accessToken = data['access_token'] as String?;
    if (accessToken != null && accessToken.isNotEmpty) {
      _client.setToken(accessToken);
    }

    // Fetch current user with the token we just set
    final userResponse = await _dio.get('/auth/me');
    final userData = userResponse.data as Map<String, dynamic>;

    // Attach token so upper layers can map it if needed
    return {
      ...userData,
      'token': accessToken,
    };
  }

  @override
  Future<void> logout() async {
    // Backend may not need an explicit logout; just clear token locally
    _client.clearToken();
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser() async {
    final response = await _dio.get('/auth/me');
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      await getCurrentUser();
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> updateProfile({
    required String name,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
    String? profileImageUrl,
  }) async {
    // Assuming PUT /users/me or similar – adjust as needed
    final response = await _dio.put(
      '/users/me',
      data: {
        'username': name,
        if (phone != null) 'phone': phone,
        if (address != null) 'address': address,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // Implement if backend exposes such endpoint
    throw UnimplementedError();
  }

  @override
  Future<void> forgotPassword(String email) async {
    // Implement if backend exposes such endpoint
    throw UnimplementedError();
  }

  @override
  Future<void> verifyEmail(String token) async {
    // Implement if backend exposes such endpoint
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    // Implement if backend exposes such endpoint
    throw UnimplementedError();
  }

  @override
  Future<String> uploadProfileImage(String imagePath) async {
    // Implement if backend exposes such endpoint
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount() async {
    // Implement if backend exposes such endpoint
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> socialLogin({
    required String provider,
    required String token,
  }) async {
    // Not supported in current backend spec
    throw UnimplementedError();
  }

  @override
  Future<void> linkSocialAccount({
    required String provider,
    required String token,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<void> unlinkSocialAccount(String provider) async {
    throw UnimplementedError();
  }
}

/// Previous mock implementation (kept for reference, can be removed later)
