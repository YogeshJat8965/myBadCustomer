import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static const String _keyToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';

  static Future<void> saveTokens({required String access, required String refresh}) async {
    await _storage.write(key: _keyToken, value: access);
    await _storage.write(key: _keyRefreshToken, value: refresh);
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _keyToken);
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefreshToken);
  }

  static Future<void> clearTokens() async {
    await _storage.delete(key: _keyToken);
    await _storage.delete(key: _keyRefreshToken);
  }
}
