import 'package:blaemuya/core/api/endpoints.dart';
import 'package:blaemuya/model/professional_model.dart';
import 'package:blaemuya/utils/tocken_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blaemuya/core/api/dio_client.dart';
import 'package:dio/dio.dart';

class UserState {
  final User? user; // The current user
  final bool isLoading; // Loading state
  final String? error; // Error message

  UserState({this.user, this.isLoading = false, this.error});
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(UserState());
  final Dio dioClient = Dio();

  // Method to fetch user profile
  Future<void> fetchUserProfile() async {
    final String? token = await TokenStorage.getToken();
    state = UserState(isLoading: true); // Set loading to true
    print("Token received: $token");

    try {
      final user = await fetchUserFromBackend(token!);
      print('Final User object: $user');
      state = UserState(user: user, isLoading: false);
    } catch (e) {
      print("Error: $e");
      state = UserState(isLoading: false, error: e.toString());
    }
  }

  // API call to fetch user data
  Future<User> fetchUserFromBackend(String token) async {
    print("Token inside fetchUserFromBackend: $token");
    try {
      final response = await dioClient.get(
        'https://balemuya-project.onrender.com/api/users/profile/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        print('User data fetched successfully');
        final userData = response.data['user']; // Outer user object
        final nestedUser = userData['user']; // Inner user object with details
        print('Nested user data: $nestedUser');

        // Convert the nested user data into a User object
        return User.fromJson(nestedUser);
      } else {
        print('Status code is not 200');
        throw Exception('Error fetching user data');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Error fetching user data');
    }
  }
}
