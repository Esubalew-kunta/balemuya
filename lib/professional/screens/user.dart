import 'package:blaemuya/providers/professional_provider.dart';
import 'package:blaemuya/utils/tocken_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  @override
  void initState() {
    final Dio dioClient = Dio();
    super.initState();
    // Use Future.microtask to fetch user profile after the build is complete
    Future.microtask(() {
      final token = TokenStorage.getToken();
      print("token inside init state $token");
      ref.read(userProvider.notifier).fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);

    // Loading state
    if (userState.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    // Error state
    if (userState.error != null) {
      return Center(child: Text('Error: ${userState.error}'));
    }

    // User data available
    if (userState.user != null) {
      return Scaffold(
        appBar: AppBar(title: Text('User Profile')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome, ${userState.user!.first_name}'),
              Text('Email: ${userState.user!.email}'),
              if (userState.user!.phone_number != null)
                Text('Phone: ${userState.user!.phone_number}'),
              if (userState.user!.addresses != null)
                Text('Address: ${userState.user!.addresses}'),
            ],
          ),
        ),
      );
    }

    return Center(child: Text('No user data available.'));
  }
}
