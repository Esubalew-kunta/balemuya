import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/common/screens/otp.dart';
import 'package:blaemuya/common/screens/passwordResetByEmail.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/large_button.dart';
import 'package:blaemuya/widgets/snack_bar.dart';
import 'package:blaemuya/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Passwordresetbyphone extends ConsumerStatefulWidget {
  static const routeName = '/forgot-password';
  const Passwordresetbyphone({Key? key}) : super(key: key);

  @override
  _PasswordresetbyphoneState createState() => _PasswordresetbyphoneState();
}

class _PasswordresetbyphoneState extends ConsumerState<Passwordresetbyphone> {
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
      backgroundColor: const Color.fromARGB(255, 248, 244, 244),
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
                        'Enter your phone number for the verification process,\n'
                        'we will send code to your phone number',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 40),
                      CustomTextFormField(
                        // controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: '09/07...',
                        prefixIcon: Icons.phone,
                        validator: (value) {
                           if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    } else if (value.length > 10 || value.length < 10) {
                      return 'Phone mumber must be 10 digits';
                    } else if (!RegExp(r'^(09|07)[0-9]{8}$').hasMatch(value)) {
                      return 'Please start  with 09 or 07 ';
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
                                    builder: (context) => const Passwordresetbyemail(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Reset by Email",
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
