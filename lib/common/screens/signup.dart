import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:blaemuya/widgets/small_button_bright.dart';
import 'package:blaemuya/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Signup extends ConsumerStatefulWidget {
  @override
  ConsumerState<Signup> createState() => _CustomStepperState();
}

class _CustomStepperState extends ConsumerState<Signup> {
  int _currentStep = 0;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _selectedGender;

  @override
  void initState() {
    super.initState();
  }

// Function to handle form submission
  void _submitData() async {
    if ((_formKey1.currentState?.validate() ?? false) &&
        (_formKey2.currentState?.validate() ?? false)) {
      final recordData = {
        "first_name": _firstNameController.text,
        "middle_name": _middleNameController.text,
        "last_name": _lastNameController.text,
        "phone_number": _phoneController.text,
        "email": _emailController.text,
        "gender": _selectedGender,
      };

      try {} catch (e) {}
    }
  }

//
  List<Step> stepList() => [
        // step 1
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
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.person,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter your first name';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: _middleNameController,
                  labelText: 'Middle Name',
                  prefixIcon: Icons.person,
                  keyboardType: TextInputType.text,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter your middle name';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: _lastNameController,
                  labelText: 'Last Name',
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.person,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter your last name';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),

        //step 2
        Step(
          title: const Text(" "),
          isActive: _currentStep >= 1,
          state: _currentStep == 1 ? StepState.editing : StepState.complete,
          content: Form(
            key: _formKey2,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.phone,
                  // keyboardType: TextInputType.phone,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter your phone number';
                  //   } else if (value.length > 10 || value.length < 10) {
                  //     return 'Phone mumber must be 10 digits';
                  //   } else if (!RegExp(r'^(09|07)[0-9]{8}$').hasMatch(value)) {
                  //     return 'Please start  with 09 or 07 ';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Gender',
                    prefixIcon: Icon(Icons.arrow_drop_down),
                  ),
                  value: _selectedGender,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please select gender';
                  //   }
                  //   return null;
                  // },
                  items: const [
                    DropdownMenuItem(
                      value: 'male',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: 'female',
                      child: Text('Female'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                    controller: _emailController,
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    })
              ],
            ),
          ),
        ),
      ];

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Balemuya"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Stepper(
                steps: stepList(),
                type: StepperType.horizontal,
                elevation: 5,
                currentStep: _currentStep,
                onStepContinue: () {
                  final isValid = _validateCurrentStep();
                  if (isValid && _currentStep < stepList().length - 1) {
                    {
                      setState(() {
                        _currentStep++;
                      });
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
                controlsBuilder: (context, details) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentStep > 0 &&
                          _currentStep < stepList().length - 1)
                        TextButton(
                          onPressed: details.onStepCancel,
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: const Size(100, 40),
                            foregroundColor: const Color.fromRGBO(9, 19, 58, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                  color: Color.fromRGBO(9, 19, 58, 1),
                                  width: 1.5),
                            ),
                          ),
                          child: const Text("Back"),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (_currentStep < stepList().length - 1)
                            ElevatedButton(
                              onPressed: details.onStepContinue,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(9, 19, 58, 1),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(100, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("NEXT"),
                            ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }

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
}
