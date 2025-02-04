import 'package:blaemuya/core/api/dio_client.dart';
import 'package:blaemuya/core/api/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final DioClient dioClient;

  AuthRepository({required this.dioClient});

  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> userData) async {
  try {
    final response = await dioClient.dio.post(
      Endpoints.register,
      data: userData,
    );

    if (response.statusCode == 201) {
      debugPrint('Registration successful: ${response.data}');
      return {
        "success": true,
        "message": response.data["message"] ?? "Registration successful",
      };
    } else {
      return {
        "success": false,
        "message": _extractErrorMessage(response),
      };
    }
  } on DioException catch (e) {
    debugPrint('Registration error: ${e.response?.data}');
    return {
      "success": false,
      "message": _extractErrorMessage(e.response),
    };
  }
}

/// Extract error messages from the backend response
String _extractErrorMessage(Response? response) {
  if (response != null && response.data is Map<String, dynamic>) {
    final errorData = response.data as Map<String, dynamic>;
    return errorData.values
        .map((error) => (error is List) ? error.join(" ") : error.toString())
        .join("\n");
  }
  return "An unexpected error occurred. Please try again.";
}


  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> credentials) async {
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
      throw _handleDioError(e);  // Pass the error up to the UI layer
    }
  }

  String _handleDioError(DioException e) {
    final response = e.response;
    if (response != null) {
      debugPrint('Error response: ${response.data}');
      return response.data['message'] ?? 'An error occurred';
    }
    return 'Network error: ${e.message}';
  }

  // Other methods follow a similar pattern...
}
