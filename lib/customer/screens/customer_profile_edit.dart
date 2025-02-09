import 'dart:io';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/gender_dropdown.dart';
import 'package:blaemuya/widgets/large_button.dart';
import 'package:blaemuya/widgets/large_text_input_field.dart';
import 'package:blaemuya/widgets/multi_select_dropdown.dart';
import 'package:blaemuya/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomerProfileEdit extends StatefulWidget {
  @override
  _CustomerProfileEditState createState() => _CustomerProfileEditState();
}

class _CustomerProfileEditState extends State<CustomerProfileEdit> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
 


  String? _imagePath;
  String? _selectedGender;
  // Image picker function
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void Update() async {
    if (_formKey.currentState!.validate()) {
      //handle the form and edit
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Profile Picture with Edit Icon
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: _imagePath != null
                                ? FileImage(File(_imagePath!))
                                : AssetImage('assets/images/avator.png')
                                    as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: pickImage,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: primaryColor,
                                child: Icon(Icons.edit,
                                    size: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Input Fields
                      CustomTextFormField(
                        controller: _firstNameController,
                        labelText: 'First Name',
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          } else if (!RegExp(r'^[a-zA-Z\s]+$')
                              .hasMatch(value)) {
                            return 'Only letters are allowed';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _firstNameController.text = value;
                          print("Text changed: $value");
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        controller: _middleNameController,
                        labelText: 'Middle Name',
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          } else if (!RegExp(r'^[a-zA-Z\s]+$')
                              .hasMatch(value)) {
                            return 'Only letters are allowed';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _middleNameController.text = value;
                          print("Text changed: $value");
                        },
                      ),

                      SizedBox(height: 10),
                      CustomTextFormField(
                        controller: _lastNameController,
                        labelText: 'Last Name',
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          } else if (!RegExp(r'^[a-zA-Z\s]+$')
                              .hasMatch(value)) {
                            return 'Only letters are allowed';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _lastNameController.text = value;
                          print("Text changed: $value");
                        },
                      ),
                      SizedBox(height: 10),
                      // Gender Dropdown
                      CustomGenderDropdown(
                        labelText: "Gender",
                        prefixIcon: Icons.person,
                        value: _selectedGender,
                        items: const [
                          DropdownMenuItem(value: 'male', child: Text('Male')),
                          DropdownMenuItem(
                              value: 'female', child: Text('Female')),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a gender';
                          }
                          return null;
                        },
                        onChanged: (newValue) {
                          setState(() {
                            _selectedGender = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        controller: _phoneController,
                        labelText: 'Phone Number',
                        prefixIcon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (value.length > 10 || value.length < 10) {
                            return 'Phone mumber must be 10 digits';
                          } else if (!RegExp(r'^(09|07)[0-9]{8}$')
                              .hasMatch(value)) {
                            return 'Please start  with 09 or 07 ';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _phoneController.text = value;
                          print("Text changed: $value");
                        },
                      ),
                      SizedBox(height: 10),
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
                      SizedBox(height: 20),
                     
                   
                      // Update Button
                      SizedBox(
                          width: double.infinity,
                          child: LargeButton(
                            text: "Update",
                            onTap: Update,
                          )),
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
