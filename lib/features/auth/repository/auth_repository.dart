import 'package:blaemuya/core/api/dio_client.dart';
import 'package:blaemuya/core/api/endpoints.dart';
import 'package:blaemuya/core/storage/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final DioClient dioClient;

  AuthRepository({required this.dioClient});

  Future<Map<String, dynamic>> registerUser(
      Map<String, dynamic> userData) async {
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
//logout

  Future<String> logoutUser() async {
    try {
      final response = await dioClient.dio.post(
        Endpoints.logout,
      );

      if (response.statusCode == 200) {
        debugPrint('logged out successfilly: ${response.data}');
        final tokenStorage = TokenStorage();
        await tokenStorage.deleteAllTokens();

        return "Logout successful";
      }
    } catch (e) {
      debugPrint('Logout error: $e');
      return "Logout faileddd";
    }
    return "Logout failed";
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

  Future<Map<String, dynamic>> loginUser(
      Map<String, dynamic> credentials) async {
    try {
      final response = await dioClient.dio.post(
        Endpoints.login,
        data: credentials,
      );

      // Save tokens to storage
      final tokenStorage = TokenStorage(); // Create an instance

      final accessToken = response.data['user']['access'];
      final refreshToken = response.data['user']['refresh'];

      await tokenStorage
          .saveAccessToken(accessToken); // Call methods using the instance
      final token = await tokenStorage.getAccessToken();
      debugPrint('Tokens: $token');

      // final accessToken = response.data['user']['access'];
      // final refreshToken = response.data['user']['refresh'];
      // await TokenStorage.saveAccessToken(accessToken);
      //  final token = await TokenStorage.getAccessToken();
      debugPrint('Tokens: $token');

      // Return the full response
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e); // Pass the error up to the UI layer
    }
  }

  String _handleDioError(DioException e) {
    final response = e.response;
    if (response != null) {
      debugPrint('Error response: ${response.data}');
      // Extract error message from the backend response
      if (response.data is Map<String, dynamic>) {
        final errorData = response.data as Map<String, dynamic>;
        // Check for the "error" key in the response
        if (errorData.containsKey('error')) {
          return errorData['error']; // Return the error message
        }
      }
    }
    return 'An error occurred. Please try again.'; // Fallback message
  }
}
