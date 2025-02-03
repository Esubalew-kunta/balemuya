import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: 'refresh_token', value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  Future<void> deleteAllTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }
}