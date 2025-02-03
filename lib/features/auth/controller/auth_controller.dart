import 'package:blaemuya/core/api/dio_client.dart';
import 'package:blaemuya/core/storage/token_storage.dart';
import 'package:blaemuya/features/auth/repository/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dioClient = DioClient(
    dio: Dio(),
    tokenStorage: TokenStorage(),
  );
  return AuthRepository(dioClient: dioClient);
});

final authControllerProvider = Provider<AuthController>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthController(repository);
});

class AuthController {
  final AuthRepository _repository;

  AuthController(this._repository);

  Future<void> registerUser(Map<String, dynamic> userData) async {
    try {
      await _repository.registerUser(userData);
      // Handle success
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await _repository.loginUser({
        'email': email,
        'password': password,
      });
      // Handle success
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

 
}