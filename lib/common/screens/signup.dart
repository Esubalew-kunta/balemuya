import 'package:blaemuya/widgets/small_button_bright.dart';
import 'package:blaemuya/widgets/small_button_dark.dart';
import 'package:blaemuya/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController givenNameController = TextEditingController();
  final TextEditingController fathersNameController = TextEditingController();
  final TextEditingController grandFathersNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Balemuya",
          style: TextStyle(
            color: Colors.black, // Set the color of the text
            fontSize: 14, // Set the font size
            fontWeight: FontWeight.w300, // Set the font weight (bold)
            letterSpacing: 1.2, // Adjust the letter spacing
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Image
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/onboardingImg2.png', // Replace with your asset path
                height: 250,
              ),
            ),

            // Custom Stepper Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: [
                  // First Step (User Icon)
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: _currentStep == 0
                              ? const Color.fromARGB(255, 0, 0, 0)
                              : Colors.grey[300],
                          radius: 16,
                          child: Icon(
                            Icons.person,
                            color:
                                _currentStep == 0 ? Colors.white : Colors.grey,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text("Step 1",
                            style: TextStyle(
                                fontSize: 12,
                                color: _currentStep == 0
                                    ? const Color.fromARGB(255, 10, 10, 10)
                                    : Colors.grey)),
                      ],
                    ),
                  ),
                  // Connector Line
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: _currentStep > 0
                          ? const Color.fromARGB(255, 0, 0, 0)
                          : Colors.grey[300],
                    ),
                  ),
                  // Second Step (Lock Icon)
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: _currentStep == 1
                              ? const Color.fromARGB(255, 0, 0, 0)
                              : Colors.grey[300],
                          radius: 16,
                          child: Icon(
                            Icons.lock,
                            color:
                                _currentStep == 1 ? Colors.white : Colors.grey,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text("Step 2",
                            style: TextStyle(
                                fontSize: 12,
                                color: _currentStep == 1
                                    ? const Color.fromARGB(255, 10, 10, 10)
                                    : Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Stepper Widget
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (_currentStep == 0)
                          CustomTextFormField(
                            // controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            labelText: 'First name',
                            prefixIcon: Icons.email,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your email';
                            //   } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            //       .hasMatch(value)) {
                            //     return 'Please enter a valid email';
                            //   }
                            //   return null;
                            // },
                          ),
                        SizedBox(height: 10),
                        if (_currentStep == 0)
                          CustomTextFormField(
                            // controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            labelText: 'First name',
                            prefixIcon: Icons.email,
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please enter your email';
                            //     } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            //         .hasMatch(value)) {
                            //       return 'Please enter a valid email';
                            //     }
                            //     return null;
                            //   },
                          ),
                        SizedBox(height: 10),
                        if (_currentStep == 0)
                          CustomTextFormField(
                            // controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            labelText: 'First name',
                            prefixIcon: Icons.email,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your email';
                            //   } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            //       .hasMatch(value)) {
                            //     return 'Please enter a valid email';
                            //   }
                            //   return null;
                            // },
                          ),
                        SizedBox(height: 10),
                        if (_currentStep == 1)
                          CustomTextFormField(
                            // controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            labelText: 'First name',
                            prefixIcon: Icons.email,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your email';
                            //   } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            //       .hasMatch(value)) {
                            //     return 'Please enter a valid email';
                            //   }
                            //   return null;
                            // },
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallButtonDark(
                        onTap: () {
                          // Navigate to login page
                        },
                        text: "Back",
                        isSelected: false,
                      ),
                      TextButton(
                        onPressed: _currentStep > 0
                            ? () {
                                setState(() {
                                  _currentStep--;
                                });
                              }
                            : null,
                        child: Text(""),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_currentStep < 1) {
                              setState(() {
                                _currentStep++;
                              });
                            } else {
                              print("Form Submitted");
                            }
                          }
                        },
                        child: Text(_currentStep == 1 ? "Submit" : "Next"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Login Link
            TextButton(
              onPressed: () {
                // Navigate to login page
              },
              child: Text("Already have an account? Log in"),
            ),
          ],
        ),
      ),
    );
  }
}
