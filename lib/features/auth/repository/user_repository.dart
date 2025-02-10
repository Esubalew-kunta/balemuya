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
