import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/common/screens/onboardingScreenThree.dart';
import 'package:blaemuya/widgets/large_button.dart';
import 'package:blaemuya/widgets/password_field.dart';
import 'package:blaemuya/widgets/snack_bar.dart';
import 'package:blaemuya/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  void login() async {
    if (_formKey.currentState!.validate()) {
      // Show loading animation
      setState(() {
        _isLoading = true;
      });

      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      try {
        // final response = await ref.read(authControllerProvider).login(email, password);

        // Hide loading animation
        setState(() {
          _isLoading = false;
        });

        // Show success snackbar
        showCustomSnackBar(
          context,
          title: 'Success',
          message: "response",
          type: AnimatedSnackBarType.success,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Placeholder(),
          ),
        );
      } catch (e) {
        // Hide loading animation
        setState(() {
          _isLoading = false;
        });

        // Show error snackbar
        showCustomSnackBar(
          context,
          title: 'Error',
          message: "Error to login",
          type: AnimatedSnackBarType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.03,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "Welcome back ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "Log in to your account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 80),
                          CustomTextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            labelText: 'phone 09...',
                            prefixIcon: Icons.phone,
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
                          CustomPasswordField(
                            // controller: _passwordController,
                            labelText: "Password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Placeholder(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 9, 19, 58),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          LargeButton(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Placeholder(),
                                ),
                              );
                            },
                            text: "Next",
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              const Text(
                                "Don’t have an account ? ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OnboardingScreenThree(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 9, 19, 58),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Placeholder(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
