import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FlutterSecureStorage _storage;

  AuthRepositoryImpl(this._storage);

  static const _tokenKey = 'auth_token';

  @override
  Future<void> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock validation
    if (password == 'password') { // Simple mock check
      await _storage.write(key: _tokenKey, value: 'mock_jwt_token');
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: _tokenKey);
    return token != null;
  }
}
