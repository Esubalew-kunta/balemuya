import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/common/screens/login.dart';
import 'package:blaemuya/common/screens/onboardingScreenOne.dart';
import 'package:blaemuya/common/screens/onboardingScreenTwo.dart';
import 'package:blaemuya/common/screens/signup.dart';

import 'package:blaemuya/widgets/large_button.dart';
import 'package:blaemuya/widgets/password_field.dart';
import 'package:blaemuya/widgets/small_button_bright.dart';
import 'package:blaemuya/widgets/small_button_dark.dart';
import 'package:blaemuya/widgets/snack_bar.dart';
import 'package:blaemuya/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreenThree extends StatefulWidget {
  @override
  _OnboardingScreenThreeState createState() => _OnboardingScreenThreeState();
}

class _OnboardingScreenThreeState extends State<OnboardingScreenThree> {
  String selectedRole = ''; // To store the selected role

 void navigateToSignUp(BuildContext context) {
  if (selectedRole.isNotEmpty) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Signup(role: selectedRole), 
      ),
    );
  } else {
    showCustomSnackBar(
      context,
      title: 'Info',
      message: "Select your role",
      type: AnimatedSnackBarType.info,
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
           padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0,bottom: 50.0),
          child: Column(
            children: [
              // Back button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Illustration
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/onboardingImg3.png', // Add your image here
                    height: 250,
                  ),
                ),
              ),

              // Title and description
              const Text(
                'Be Part of the Professional Network',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Are you here to offer services or find help?\n '
                'Choose your role to get started.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),
              // Role selection: Customer or Professional
              const Text(
                'I am a',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Customer button
                  SmallButtonDark(
                    onTap: () {
                      setState(() {
                        selectedRole = 'customer';
                      });
                    },
                    text: 'Customer',
                    isSelected: selectedRole == 'customer',
                  ),
                  const SizedBox(width: 20),

                  // Professional button
                  SmallButtonBright(
                    onTap: () {
                      setState(() {
                        selectedRole = 'professional';
                      });
                    },
                    text: 'Professional',
                    isSelected: selectedRole == 'professional',
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Next button
              LargeButton(
                onTap: () async  {
                  final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('hasSeenOnboarding', true);
                  navigateToSignUp(context);
                },
                text: 'Next',
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

