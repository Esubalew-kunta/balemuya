import 'package:blaemuya/core/api/dio_client.dart';
import 'package:blaemuya/core/api/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final DioClient dioClient;

  AuthRepository({required this.dioClient});

  Future<void> registerUser(Map<String, dynamic> userData) async {
    try {
      final response = await dioClient.dio.post(
        Endpoints.register,
        data: userData,
      );

      if (response.statusCode == 200) {
        debugPrint('Registration successful: ${response.data}');
      return;
      } else {
          throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: response.data['message'] ?? 'Registration failed',
        );
      }
    } on DioException catch (e) {
     debugPrint('Registration error: ${e.response?.data}');
    throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> loginUser(
      Map<String, dynamic> credentials) async {
    try {
      final response = await dioClient.dio.post(
        Endpoints.login,
        data: credentials,
      );

      final accessToken = response.data['access'];
      final refreshToken = response.data['refresh'];

      await dioClient.tokenStorage.saveAccessToken(accessToken);
      await dioClient.tokenStorage.saveRefreshToken(refreshToken);

      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  String _handleDioError(DioException e) {
    final response = e.response;
    if (response != null) {
      return response.data['message'] ?? 'An error occurred';
    }
    return 'Network error: ${e.message}';
  }

  // Other methods follow similar pattern...
}
