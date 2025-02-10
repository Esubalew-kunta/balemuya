import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/common/screens/onboardingScreenOne.dart';
import 'package:blaemuya/common/screens/onboardingScreenThree.dart';
import 'package:blaemuya/common/screens/onboardingScreenTwo.dart';
import 'package:blaemuya/customer/screens/customer_bottom_nav.dart';
import 'package:blaemuya/features/auth/controller/auth_controller.dart';
import 'package:blaemuya/professional/screens/bottom_nav.dart';
import 'package:blaemuya/professional/screens/pHome.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:blaemuya/widgets/large_button.dart';
import 'package:blaemuya/widgets/loading_indicator.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _newPasswordVisible = false;
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String? _newPassword;

  void login() async {
    if (_formKey.currentState!.validate()) {
      // setState(() {
      //   _isLoading = true;
      // });

      final email = _emailController.text.trim();
      final password = _newPasswordController.text.trim();

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child:LoadingIndicatorWidget()),
        );

        final response =
            await ref.read(authControllerProvider).loginUser(email, password);

        // Hide loading dialog
           if(mounted) Navigator.pop(context);

        // Show success snackbar with the response message
        AnimatedSnackBar.material(
          response["message"],
          type: AnimatedSnackBarType.success,
        ).show(context);

        // Extract user type from the response
        final userType = response['user']['user_type'];

        // Redirect user based on their type
        if (userType == 'customer') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerBottomNav(),
            ),
          );
        } else if (userType == 'professional') {
          
          showCustomSnackBar(
          context,
          title: 'Success',
          message: "You've successfully logged in!",
          type: AnimatedSnackBarType.success,
        );
         
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  ProfessionalBottomBar(),
            ),
          );
        } 
        else if (userType == 'admin') {
          showCustomSnackBar(
          context,
          title: 'info',
          message: "Admin cannot login via mobile app",
          type: AnimatedSnackBarType.info,
        );
          return;
       
        }
      } catch (e) {
        // Hide loading dialog
        if (mounted) Navigator.pop(context);

        // Show error snackbar with the server's error message
        AnimatedSnackBar.material(
          e.toString(), // Display the error message
          type: AnimatedSnackBarType.error,
        ).show(context);
      } finally {
        // Ensure loading state is reset
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Balemuya"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                            labelText: 'Email',
                            prefixIcon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _emailController.text = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _newPasswordController,
                            obscureText: !_newPasswordVisible,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromRGBO(245, 245, 245, 1.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: " Password",
                              prefixIcon: const Icon(Icons.lock),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 222, 228, 233),
                                    width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 198, 206, 212),
                                    width: 2),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _newPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _newPasswordVisible = !_newPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
                            onSaved: (value) => _newPassword = value,
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
                              login();
                            },
                            text: "Login",
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
