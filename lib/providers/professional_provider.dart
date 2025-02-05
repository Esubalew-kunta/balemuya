
import 'package:blaemuya/states/user_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});
