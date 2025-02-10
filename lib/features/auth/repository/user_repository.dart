import 'package:blaemuya/core/api/dio_client.dart';
import 'package:blaemuya/core/api/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserRepository {
  final DioClient dioClient;

  UserRepository({required this.dioClient});
//fetch profile
  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await dioClient.dio.get(
        Endpoints.profile,
      );

      if (response.statusCode == 200) {
        debugPrint('Profile fetched successful: ${response.data}');
        print("professionalData${response.data}");
        return response.data;
      } else {
        return {
          "success": false,
          "message": _extractErrorMessage(response),
        };
      }
    } on DioException catch (e) {
      debugPrint('profile fetch error : ${e.response?.data}');
      return {
        "success": false,
        "message": _extractErrorMessage(e.response),
      };
    }
  }

//update profile
  Future<Map<String, dynamic>> updateUseProfile(
      String userId, FormData userData) async {
    try {
      // Send a POST request to the profile update endpoint

      print("Starting to update....");
      final response = await dioClient.dio.put(
          Endpoints.updateProfile, // Assuming this is the correct endpoint
          data: userData,
          options: Options(headers: {'Content-Type': 'multipart/form-data'}));

      // Check if the response is successful
      if (response.statusCode == 200) {
        debugPrint('Profile Update successful: ${response.data}');
        return {
          'success': true,
          'message': 'Profile updated successfully!',
        };
      } else {
        print({response.statusMessage});
        return {
          'success': false,
          'message': 'Failed to update profile: ${response.statusMessage}',
        };
      }
    } on DioException catch (e) {
      
      // Handle DioError exceptions (e.g., network issues, timeout, etc.)
      debugPrint('Profile update error: ${e.response?.data}');
      return {
        'success': false,
        'message': 'Error occurred: ${_ErrorMessage(e.response)}',
      };
    }
  }

//fetch new jobs
  Future<Map<String, dynamic>> getNewJobs() async {
    try {
      final response = await dioClient.dio.get(
        Endpoints.profile,
      );

      if (response.statusCode == 200) {
        debugPrint('Profile fetched successful: ${response.data}');
        print("professionalData${response.data}");
        return response.data;
      } else {
        return {
          "success": false,
          "message": _extractErrorMessage(response),
        };
      }
    } on DioException catch (e) {
      debugPrint('profile fetch error : ${e.response?.data}');
      return {
        "success": false,
        "message": _extractErrorMessage(e.response),
      };
    }
  }

  String _ErrorMessage(Response? response) {
    if (response?.data != null) {
      return response!.data['message'] ?? 'An unknown error occurred.';
    }
    return 'Network error or server unreachable.';
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
}
