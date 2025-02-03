import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/common/screens/otp.dart';
import 'package:blaemuya/common/screens/passwordResetByPhone.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/large_button.dart';
import 'package:blaemuya/widgets/snack_bar.dart';
import 'package:blaemuya/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Passwordresetbyemail extends ConsumerStatefulWidget {
  static const routeName = '/forgot-password';
  const Passwordresetbyemail({Key? key}) : super(key: key);

  @override
  _PasswordresetbyemailState createState() => _PasswordresetbyemailState();
}

class _PasswordresetbyemailState extends ConsumerState<Passwordresetbyemail> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void sendPasswordResetLink() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      // ref.read(authControllerProvider).sendPasswordResetEmail(
      //       context: context,
      //       email: email,
      //     );

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OtpVerificationScreen(email: email),
      //   ),
      // );
    } else {
      showCustomSnackBar(
        context,
        title: 'Error',
        message: 'Please Enter valid Email address',
        type: AnimatedSnackBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    double maxWidth = 400.0;

    return Scaffold(
     
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
        backgroundColor: const Color.fromARGB(255, 248, 244, 244),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Align(
                alignment: Alignment.center,
                child: Form(
                  key: _formKey, // Attach the form key here
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Forgot password?',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 50,
                          fontFamily: 'Jakarta',
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Enter your email for the verification process,we will send'
                        ' code to your email address',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 40),
                      CustomTextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'Email',
                        prefixIcon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      LargeButton(
                        text: 'Next',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Otp(email: "esubalewkunta@gmail.com"),
                            ),
                          );
                        },
                      ),
                      SizedBox(height:  10),
                      Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Passwordresetbyphone(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Reset by SMS",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 9, 19, 58),
                                ),
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
