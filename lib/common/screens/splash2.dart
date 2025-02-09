import 'package:blaemuya/common/screens/login.dart';
import 'package:blaemuya/common/screens/onboardingScreenOne.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Enable immersive full-screen mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Navigate to Home after 5 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    // Restore system UI overlays when the widget is disposed
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            width: double.infinity,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          ),

          // Main Content (Image and Motto)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/icon/icon.png',
                  width:
                      MediaQuery.of(context).size.width * 0.6, // Scaled width
                ),
                const SizedBox(height: 20), // Add spacing between logo and text

                // Motto
                Text(
                  "Services at Your Fingertips",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 63, 61, 61),
                    fontStyle: FontStyle.italic,
                    fontSize: MediaQuery.of(context).size.width * 0.045, // Responsive font size
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
