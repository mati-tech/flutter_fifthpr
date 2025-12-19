// lib/core/services/token_storage_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _tokenTypeKey = 'token_type';

  final FlutterSecureStorage _storage;

  // Singleton pattern
  static final TokenStorageService _instance = TokenStorageService._internal();

  factory TokenStorageService() => _instance;

  TokenStorageService._internal() : _storage = const FlutterSecureStorage();

  // Save token data
  Future<void> saveTokenData({
    required String accessToken,
    String? refreshToken,
    String tokenType = 'bearer',
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }
    await _storage.write(key: _tokenTypeKey, value: tokenType);
  }

  // Get access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  // Get refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // Get token type
  Future<String?> getTokenType() async {
    return await _storage.read(key: _tokenTypeKey);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // Clear all tokens (logout)
  Future<void> clearAllTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _tokenTypeKey);
  }

  // Get full authorization header value
  Future<String?> getAuthorizationHeader() async {
    final token = await getAccessToken();
    final type = await getTokenType() ?? 'bearer';

    if (token == null) return null;
    return '$type $token';
  }
}