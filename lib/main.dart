// import 'package:blaemuya/common/screens/login.dart';
// import 'package:blaemuya/common/screens/onboardingScreenOne.dart';
// import 'package:blaemuya/common/screens/onboardingScreenThree.dart';
// import 'package:blaemuya/common/screens/onboardingScreenTwo.dart';
// import 'package:blaemuya/common/screens/passwordResetByEmail.dart';
// import 'package:blaemuya/common/screens/signup.dart';

// import 'package:blaemuya/customer/screens/customer_bottom_nav.dart';
// import 'package:blaemuya/customer/screens/customer_home.dart';
// import 'package:blaemuya/customer/screens/customer_jobs_list.dart';
// import 'package:blaemuya/customer/screens/customer_profile_edit.dart';
// import 'package:blaemuya/customer/screens/jobs/post_job.dart';
// import 'package:blaemuya/customer/screens/jobs/nearby_professionals_map.dart';
// import 'package:blaemuya/professional/screens/Professional_payment.dart';
// import 'package:blaemuya/professional/screens/bottom_nav.dart';
// import 'package:blaemuya/professional/screens/pHome.dart';
// import 'package:blaemuya/professional/screens/subscription_options.dart';
// import 'package:blaemuya/professional/screens/varified_profile_edit.dart';
// import 'package:blaemuya/professional/screens/professional_profile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// void main() {
//   runApp(
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {

//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home:   SplashScreen(),
//     );
//   }
// }

import 'package:blaemuya/common/screens/splash.dart';

import 'package:blaemuya/common/screens/onboardingScreenOne.dart';
import 'package:blaemuya/common/screens/splash2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blaemuya/common/screens/onboardingScreenThree.dart';
import 'package:blaemuya/common/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

  runApp(
    ProviderScope(
      child: MyApp(hasSeenOnboarding: hasSeenOnboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;

  const MyApp({super.key, required this.hasSeenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: hasSeenOnboarding ? Splash2() : SplashScreen(),
    );
  }
}
