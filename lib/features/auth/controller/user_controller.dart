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

// update current locatioin
 Future<Map<String, dynamic>> updateCurrentLocation(
      Map<String, dynamic> locationData) async {
    return await _repository.updateLocation(locationData);
  }
//upload certificate
 Future<Response> updateCertificate({required FormData updatedCertificate}) async {
   print("Updated Certificate Fields:");
  updatedCertificate.fields.forEach((field) {
    print("${field.key}: ${field.value}");
  });

  // Print all files
  print("Updated Certificate Files:");
  updatedCertificate.files.forEach((file) {
    print("${file.key}: ${file.value.filename}");
  });
    return await _repository.uploadCertificate(updatedCertificate);
    
  }

//update profile
Future<Map<String, dynamic>> updateUserProfile({
  required String userId,
  required FormData updatedData,
}) async {
  try {
    // Call the repository method to update the user profile
    final response = await _repository.updateUseProfile(userId, updatedData);

    // Return the response with success and message
    return {
      'success': response['success'],
      'message': response['message'],
    };
  } catch (e) {
    // Return error in case of exception
    return {
      'success': false,
      'message': 'Error: $e',
    };
  }
}

 
}













