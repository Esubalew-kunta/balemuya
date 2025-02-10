import 'package:blaemuya/core/api/dio_client.dart';
import 'package:blaemuya/core/storage/token_storage.dart';
import 'package:blaemuya/features/auth/repository/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dioClient = DioClient(
    dio: Dio(),

    tokenStorage: TokenStorage(),
  );
  return UserRepository(dioClient: dioClient);
});

final userControllerProvider = Provider<UserController>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UserController(repository);
});

class UserController {
  final UserRepository _repository;

  UserController(this._repository);

  Future<Map<String, dynamic>> getUserProfile() async {
  return await _repository.getProfile();
}
 
}