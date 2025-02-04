import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/common/screens/login.dart';
import 'package:blaemuya/features/auth/controller/auth_controller.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:blaemuya/widgets/gender_dropdown.dart';
import 'package:blaemuya/widgets/text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Signup extends ConsumerStatefulWidget {
  final String role;
  const Signup({super.key, required this.role});

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
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

  // List of steps
  List<Step> stepList() => [
        // Step 1: Personal Details
        Step(

          title: const Text(""),
          isActive: _currentStep >= 0,
          state: _currentStep == 0 ? StepState.editing : StepState.complete,
          content: Form(

            key: _formKey1,
            child: Column(
              children: [
                CustomTextFormField(
                        controller: _firstNameController,
                        labelText: 'First Name',
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.name,
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter your name';
                        //   }
                        //   return null;
                        // },
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
                    DropdownMenuItem(value: 'male', child: Text('Male')),
                    DropdownMenuItem(value: 'female', child: Text('Female')),
                  ],
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),

        // Step 2: Address Details
        Step(
          title: const Text(""),
          isActive: _currentStep >= 1,
          state: _currentStep == 1 ? StepState.editing : StepState.complete,
          content: Form(
            key: _formKey2,
            child: Column(
              children: [
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
                const SizedBox(height: 10),
               TextFormField(
                        controller: _newPasswordController,
                        obscureText: !_newPasswordVisible,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(245, 245, 245, 1.0),
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
                        onSaved: (value) => _newPassword = value,
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !_confirmPasswordVisible,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(245, 245, 245, 1.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Confirm Password",
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
                              _confirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _confirmPasswordVisible = !_confirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: _confirmPasswordValidator,
                        onSaved: (value) => _confirmPassword = value,
                      ),
                      SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ];

  // Validate the current step
  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _formKey1.currentState?.validate() ?? false;
      case 1:
        return _formKey2.currentState?.validate() ?? false;
      default:
        return false;
    }
  }

  @override
 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: CustomText("Balemuya"),
      centerTitle: true,
      backgroundColor: Colors.white,
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/onboardingImg2.png',
            height: 250, // Adjust height as needed
          ),
        ),
        Expanded(
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary:primaryColor),             
              shadowColor:Colors.transparent, 
              canvasColor: Colors.white, 
              
            ),
            child: Stepper(
              steps: stepList(),
              type: StepperType.horizontal,
              currentStep: _currentStep,
              controlsBuilder: (context, details) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,      
                  children: [             
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    
                    if (_currentStep == 0)
                     TextButton(
                   onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      minimumSize: const Size(100, 40),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    child: const Text("Back"),
                  ) else if (_currentStep > 0)
                     TextButton(
                    onPressed:details.onStepCancel,
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
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(100, 40),
                        
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(_currentStep < stepList().length - 1
                          ? "Next"
                          : "Submit"),
                    ),
                    
                  ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
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
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
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
                    )
                  ],
                  
                );
              },
              onStepContinue: () {
                if (_validateCurrentStep()) {
                  if (_currentStep < stepList().length - 1) {
                    setState(() {
                      _currentStep++;
                    });
                  } else {
                    _submitData();
                  }
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep--;
                  });
                }
              },
              
            ),
            
          ),
          
        ),
        
      ],
    ),
  );
}


}