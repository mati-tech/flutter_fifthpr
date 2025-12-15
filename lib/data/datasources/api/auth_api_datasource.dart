// lib/data/datasources/auth_api_datasource.dart

abstract class AuthApiDataSource {
  // Register new user
  Future<Map<String, dynamic>> register({
    required String name,
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

class MockAuthApiDataSource implements AuthApiDataSource {
  final Map<String, dynamic> _mockUser = {
    'id': '1',
    'email': 'demo@storelytech.com',
    'name': 'John Doe',
    'phone': '+1 (555) 123-4567',
    'address': '123 Main Street, New York, NY 10001',
    'date_of_birth': '1990-05-15',
    'profile_image_url': null,
    'created_at': DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
    'updated_at': DateTime.now().toIso8601String(),
    'token': 'mock_jwt_token_123456',
    'refresh_token': 'mock_refresh_token_789012',
  };

  bool _isLoggedIn = false;
  String? _currentRefreshToken;

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
  }) async {
    await _simulateDelay();

    if (email == 'existing@example.com') {
      throw Exception('Email already exists');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    _isLoggedIn = true;
    _currentRefreshToken = 'refresh_token_for_$email';

    return {
      ..._mockUser,
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'message': 'Registration successful',
      'refresh_token': _currentRefreshToken,
    };
  }

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    await _simulateDelay();

    if (email == 'demo@storelytech.com' && password == 'password123') {
      _isLoggedIn = true;
      _currentRefreshToken = 'refresh_token_for_$email';

      return {
        ..._mockUser,
        'message': 'Login successful',
        'refresh_token': _currentRefreshToken,
      };
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<void> logout() async {
    await _simulateDelay();
    _isLoggedIn = false;
    _currentRefreshToken = null;
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser() async {
    await _simulateDelay();

    if (!_isLoggedIn) {
      throw Exception('Not authenticated');
    }

    return _mockUser;
  }

  @override
  Future<bool> isAuthenticated() async {
    await _simulateDelay();
    return _isLoggedIn;
  }

  @override
  Future<Map<String, dynamic>> updateProfile({
    required String name,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
    String? profileImageUrl,
  }) async {
    await _simulateDelay();

    if (!_isLoggedIn) {
      throw Exception('Not authenticated');
    }

    // Update mock user data
    _mockUser['name'] = name;
    if (phone != null) _mockUser['phone'] = phone;
    if (address != null) _mockUser['address'] = address;
    if (dateOfBirth != null) _mockUser['date_of_birth'] = dateOfBirth.toIso8601String();
    if (profileImageUrl != null) _mockUser['profile_image_url'] = profileImageUrl;
    _mockUser['updated_at'] = DateTime.now().toIso8601String();

    return {
      ..._mockUser,
      'message': 'Profile updated successfully',
    };
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _simulateDelay();

    if (!_isLoggedIn) {
      throw Exception('Not authenticated');
    }

    if (currentPassword != 'password123') {
      throw Exception('Current password is incorrect');
    }

    if (newPassword.length < 6) {
      throw Exception('New password must be at least 6 characters');
    }

    if (newPassword == currentPassword) {
      throw Exception('New password must be different from current password');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _simulateDelay();

    if (email.isEmpty || !email.contains('@')) {
      throw Exception('Valid email is required');
    }

    if (!email.endsWith('@storelytech.com')) {
      throw Exception('Password reset email sent to $email');
    }

    // Simulate sending email
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> verifyEmail(String token) async {
    await _simulateDelay();

    if (token.isEmpty) {
      throw Exception('Verification token is required');
    }

    if (token == 'valid_token_123') {
      _mockUser['email_verified_at'] = DateTime.now().toIso8601String();
    } else {
      throw Exception('Invalid verification token');
    }
  }

  @override
  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    await _simulateDelay();

    if (refreshToken.isEmpty) {
      throw Exception('Refresh token is required');
    }

    if (refreshToken != _currentRefreshToken) {
      throw Exception('Invalid refresh token');
    }

    // Generate new tokens
    final newToken = 'new_jwt_token_${DateTime.now().millisecondsSinceEpoch}';
    final newRefreshToken = 'new_refresh_token_${DateTime.now().millisecondsSinceEpoch}';

    _mockUser['token'] = newToken;
    _currentRefreshToken = newRefreshToken;

    return {
      'token': newToken,
      'refresh_token': newRefreshToken,
      'token_type': 'Bearer',
      'expires_in': 3600,
    };
  }

  @override
  Future<String> uploadProfileImage(String imagePath) async {
    await _simulateDelay();

    if (!_isLoggedIn) {
      throw Exception('Not authenticated');
    }

    if (imagePath.isEmpty) {
      throw Exception('Image path is required');
    }

    // Simulate image upload
    await Future.delayed(const Duration(seconds: 2));

    // Return mock URL
    return 'https://storelytech.com/profiles/user1_${DateTime.now().millisecondsSinceEpoch}.jpg';
  }

  @override
  Future<void> deleteAccount() async {
    await _simulateDelay();

    if (!_isLoggedIn) {
      throw Exception('Not authenticated');
    }

    // Ask for confirmation (in real app)
    await Future.delayed(const Duration(seconds: 1));

    // Clear all data
    _isLoggedIn = false;
    _currentRefreshToken = null;
    // In real app, you would clear secure storage here
  }

  @override
  Future<Map<String, dynamic>> socialLogin({
    required String provider,
    required String token,
  }) async {
    await _simulateDelay();

    if (token.isEmpty) {
      throw Exception('Social login token is required');
    }

    // Validate provider
    final validProviders = ['google', 'facebook', 'apple'];
    if (!validProviders.contains(provider.toLowerCase())) {
      throw Exception('Unsupported provider: $provider');
    }

    _isLoggedIn = true;
    _currentRefreshToken = 'social_refresh_token_$provider';

    // Update user info based on provider
    _mockUser['name'] = '$provider User';
    _mockUser['email'] = 'user@$provider.com';
    _mockUser['profile_image_url'] = 'https://$provider.com/avatar.jpg';

    return {
      ..._mockUser,
      'provider': provider,
      'message': 'Social login successful',
      'refresh_token': _currentRefreshToken,
    };
  }

  @override
  Future<void> linkSocialAccount({
    required String provider,
    required String token,
  }) async {
    await _simulateDelay();

    if (!_isLoggedIn) {
      throw Exception('Not authenticated');
    }

    if (token.isEmpty) {
      throw Exception('Social token is required');
    }

    // In real app, you would store the linked provider
    _mockUser['linked_providers'] = [...?_mockUser['linked_providers'], provider];

    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> unlinkSocialAccount(String provider) async {
    await _simulateDelay();

    if (!_isLoggedIn) {
      throw Exception('Not authenticated');
    }

    final linkedProviders = List<String>.from(_mockUser['linked_providers'] ?? []);
    if (!linkedProviders.contains(provider)) {
      throw Exception('Account not linked with $provider');
    }

    linkedProviders.remove(provider);
    _mockUser['linked_providers'] = linkedProviders;

    await Future.delayed(const Duration(seconds: 1));
  }
}