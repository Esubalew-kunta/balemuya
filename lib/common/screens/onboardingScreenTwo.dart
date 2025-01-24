import 'package:blaemuya/common/screens/onboardingScreenThree.dart';
import 'package:blaemuya/common/screens/onboardingScreenTwo.dart';
import 'package:blaemuya/widgets/large_button.dart';
import 'package:flutter/material.dart';


class OnboardingScreenTwo extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0,bottom: 50.0),
          child: Column(
            children: [
              // Skip button at the top right
    
              Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OnboardingScreenThree(), 
                        ),
                      );
                    },
                    child: const Text('Skip'),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Illustration
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/onboardingImg2.png', // Add your image here
                    height: 350,
                  ),
                ),
              ),

              // Title and description
              const Text(
                ' Why Balemuya?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Verified professionals. Quality services. Hassle-free connections.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),
               
              // Next button
              LargeButton(
                text: 'Next',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnboardingScreenThree(),
                    ),
                  );
                },
              ),
                const SizedBox(height: 20),
             
            ],
          ),
        ),
      ),
    );
  }
}