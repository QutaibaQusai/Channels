import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service for securely storing sensitive data like auth tokens
class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  // Storage keys
  static const String _authTokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';

  // ==================== AUTH TOKEN ====================

  /// Save authentication token
  static Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _authTokenKey, value: token);
  }

  /// Get authentication token
  static Future<String?> getAuthToken() async {
    return await _storage.read(key: _authTokenKey);
  }

  /// Delete authentication token
  static Future<void> deleteAuthToken() async {
    await _storage.delete(key: _authTokenKey);
  }

  /// Check if user is authenticated (has token)
  static Future<bool> isAuthenticated() async {
    final token = await getAuthToken();
    return token != null && token.isNotEmpty;
  }

  // ==================== USER ID ====================

  /// Save user ID
  static Future<void> saveUserId(String userId) async {
    await _storage.write(key: _userIdKey, value: userId);
  }

  /// Get user ID
  static Future<String?> getUserId() async {
    return await _storage.read(key: _userIdKey);
  }

  /// Delete user ID
  static Future<void> deleteUserId() async {
    await _storage.delete(key: _userIdKey);
  }

  // ==================== LOGOUT ====================

  /// Clear all stored data (logout)
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
