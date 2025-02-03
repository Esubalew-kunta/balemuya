import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/common/screens/login.dart';
import 'package:blaemuya/features/auth/controller/auth_controller.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/gender_dropdown.dart';
import 'package:blaemuya/widgets/text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Signup extends ConsumerStatefulWidget {
   final String role;  
  const Signup({super.key, required this.role});
  @override
  ConsumerState<Signup> createState() => _CustomStepperState();
}

class _CustomStepperState extends ConsumerState<Signup> {
  int _currentStep = 0;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;
    final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final  _firstNameController = TextEditingController();
  final  _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _newPassword;
  String? _confirmPassword;
  String? _selectedGender;

  String? _confirmPasswordValidator(String? value) {
    if (value!.isEmpty) {
      return "Please confirm new password";
    }
    if (value != _newPasswordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  void _submitData() async {
    if ((_formKey1.currentState?.validate() ?? false) &&
        (_formKey2.currentState?.validate() ?? false)) {

      try {
          showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

            final userData = {
        "first_name": _firstNameController.text,
        "middle_name": _middleNameController.text,
        "last_name": _lastNameController.text,
        "gender": _selectedGender,
        "phone_number": _phoneController.text,
        "email": _emailController.text,
        "password": _newPassword,
        "user_type": widget.role,
      };
     debugPrint(userData.toString());
      
      // Call the controller
    await ref.read(authControllerProvider).registerUser(userData);
  
      if (mounted) Navigator.pop(context);
        // Show successF
      AnimatedSnackBar.material(
        'Registration Successful!',
        type: AnimatedSnackBarType.success,
      ).show(context);

      // Redirect to login after 2 seconds
      if (mounted) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        });
      }

      } catch (e) {
             // Remove loading
      if (mounted) Navigator.pop(context);

      // Show error
      AnimatedSnackBar.material(
        e.toString(),
        type: AnimatedSnackBarType.error,
      ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Balemuya",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Image
            Padding(

              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/onboardingImg2.png',
                height: 250,
              ),
            ),

            // Custom Stepper Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: [
                  // First Step
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: _currentStep >= 0
                              ? primaryColor
                              : Colors.grey[300],
                          radius: 16,
                          child: Icon(
                            Icons.person,
                            color: _currentStep == 0
                                ? Colors.white
                                : const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Text(
                        //   "Step 1",
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     color: _currentStep == 0 ?  primaryColor : Colors.grey,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // Connector Line
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: _currentStep > 0 ? Colors.black : Colors.grey[300],
                    ),
                  ),
                  // Second Step
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: _currentStep == 1
                              ? Colors.black
                              : Colors.grey[300],
                          radius: 16,
                          child: Icon(
                            Icons.lock,
                            color:
                                _currentStep == 1 ? Colors.white : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Text(
                        //   "Step 2",
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     color: _currentStep == 1 ? Colors.black : Colors.grey,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Form Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    // BoxShadow(
                    //   color: Colors.black26,
                    //   blurRadius: 8,
                    //   offset: Offset(0, 4),
                    // ),
                  ],
                ),
                child: _currentStep == 0
                    //step 1
                    ? Form(
                        key: _formKey1,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              controller: _firstNameController,
                              labelText: 'First Name',
                              prefixIcon: Icons.person,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          } 
                          return null;
                        },
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              controller: _middleNameController,
                              labelText: 'Middle Name',
                              prefixIcon: Icons.person,
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              controller: _lastNameController,
                              labelText: 'Last Name',
                              prefixIcon: Icons.person,
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(height: 10),
                            CustomGenderDropdown(
                              labelText: "Select Gender",
                              prefixIcon: Icons.person,
                              value: _selectedGender,
                              items: const [
                                DropdownMenuItem(
                                    value: 'male', child: Text('Male')),
                                DropdownMenuItem(
                                    value: 'female', child: Text('Female')),
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedGender = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                      
                    //step 2
                    : Form(
                        key: _formKey2,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              controller: _phoneController,
                              labelText: 'Phone Number',
                              prefixIcon: Icons.phone,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              controller: _emailController,
                              labelText: 'Email',
                              prefixIcon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              controller: _newPasswordController,
                              obscureText: !_newPasswordVisible,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromRGBO(245, 245, 245, 1.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: " Password",
                                prefixIcon: const Icon(Icons.lock),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 222, 228, 233),
                                      width: 2), // Change color here
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 198, 206, 212),
                                      width: 2), // Change color when focused
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _newPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _newPasswordVisible =
                                          !_newPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return "Please enter password";
                              //   }
                              //   if (value.length < 6) {
                              //     return "Password must be at least 6 characters long";
                              //   }
                              //   return null;
                              // },
                              onSaved: (value) => _newPassword = value,
                            ),

                            const SizedBox(height: 10.0),

                            // Confirm New Password
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: !_confirmPasswordVisible,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromRGBO(245, 245, 245, 1.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Confirm Password",
                                prefixIcon: const Icon(Icons.lock),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 222, 228, 233),
                                      width: 2), // Change color here
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 198, 206, 212),
                                      width: 2), // Change color when focused
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _confirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _confirmPasswordVisible =
                                          !_confirmPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: _confirmPasswordValidator,
                              onSaved: (value) => _confirmPassword = value,
                            ),
                          ],
                        ),
                      ),
              ),
            ),

            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // if (_currentStep == 0)
                  //   TextButton(
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     },
                  //     style: TextButton.styleFrom(
                  //       minimumSize: const Size(100, 40),
                  //       foregroundColor: Colors.black,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //         side: const BorderSide(color: Colors.black),
                  //       ),
                  //     ),
                  //     child: const Text("Back"),
                  //   )
                   if (_currentStep > 0)
                    TextButton(
                      onPressed: () => setState(() => _currentStep--),
                      style: TextButton.styleFrom(
                        minimumSize: const Size(100, 40),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      child: const Text("Back"),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentStep == 0 &&
                          _formKey1.currentState!.validate()) {
                        setState(() => _currentStep++);
                      } else if (_currentStep == 1 &&
                          _formKey2.currentState!.validate()) {
                        _submitData();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(100, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(_currentStep == 0 ? "Next" : "Submit"),
                  ),
                ],
              ),
            ),

            // Login Link
            RichText(
              text: TextSpan(
                text: "Already have an account? ",
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: "Log in",
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
