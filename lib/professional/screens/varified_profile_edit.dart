import 'dart:io';
import 'package:blaemuya/features/auth/controller/user_controller.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/gender_dropdown.dart';
import 'package:blaemuya/widgets/large_button.dart';
import 'package:blaemuya/widgets/large_text_input_field.dart';
import 'package:blaemuya/widgets/multi_select_dropdown.dart';
import 'package:blaemuya/widgets/text_form_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEdit extends ConsumerStatefulWidget {
  final String userId;

  const ProfileEdit({Key? key, required this.userId}) : super(key: key);

  @override
  ConsumerState<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends ConsumerState<ProfileEdit> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  // List<String> _selectedOptions = [];

  String? _imagePath;
  String? _fetchedImagePath;
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

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() async {
    setState(() {
      _isLoading = true;
    });

    final data = await ref.read(userControllerProvider).getUserProfile();
    print("Fetched Data: $data"); // Debugging

    final user = data['user']['user'] ?? {};
    print("User Profile: $user"); // Debugging

    setState(() {
      _firstNameController.text = user['first_name'] ?? '';
      _middleNameController.text = user['middle_name'] ?? '';
      _lastNameController.text = user["last_name"] ?? '';
      _phoneController.text = user['phone_number'] ?? '';
      _emailController.text = user['email'] ?? '';
      _bioController.text = user['bio'] ?? '';

      _selectedGender = user['gender'] ?? '';
      _fetchedImagePath = user['profile_image_url'] ?? '';
      _isLoading = false; // Mark as loaded
      print("First Name from API: ${user['first_name']}");
    });

    print(
        "Controllers Updated: ${_firstNameController.text}, ${_emailController.text}");
  }
//submit the uodated data

  void update() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Collect the updated data
      // final updatedUserData = FormData.from{
      //   'first_name': _firstNameController.text,
      //   'middle_name': _middleNameController.text,
      //   'last_name': _lastNameController.text,
      //   'email': _emailController.text,
      //   'phone_number': _phoneController.text,
      //   'gender': _selectedGender,
      //   'bio': _bioController.text,
      //   'profile_image_url': _imagePath, // Assuming you update the profile image
      // };

      final updatedUserData = FormData.fromMap({
        'id': widget.userId,
        'first_name': _firstNameController.text,
        'middle_name': _middleNameController.text,
        'last_name': _lastNameController.text,
        'email': _emailController.text,
        'phone_number': _phoneController.text,
        'gender': _selectedGender,
        'bio': _bioController.text,
        'profile_image': await MultipartFile.fromFile(_imagePath!),
      });
      try {
        print(" updateddata $updatedUserData");
        // Call the controller method to update the user profile
        final response =
            await ref.read(userControllerProvider).updateUserProfile(
                  userId: widget
                      .userId, // Pass the userId to identify which data to update
                  updatedData: updatedUserData,
                );

        // Check if update was successful
        if (response['success'] == true) {
          // Handle success (show a success message, navigate, etc.)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully!')),
          );
        } else {
          // Handle failure (show an error message)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to update profile: ${response['message']}')),
          );
        }
      } catch (e) {
        // Handle error in case of network failure, etc.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile. Please try again.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
          // Hide loader
        });
      }
    }
  }

  // void initState() {
  //   super.initState();
  //   if (widget.userId != null) {
  //     ref.read(userControllerProvider).getUserProfile().then((user) {
  //       user = user['user'];
  //       final userProfile = user['user'] ?? {};
  //       setState(() {
  //         _firstNameController.text = userProfile['first_name'] ?? '';
  //         _middleNameController.text = userProfile['middle_name'] ?? '';
  //         _lastNameController.text = userProfile['last_name'] ?? '';
  //         _emailController.text = userProfile['email'] ?? '';
  //         _phoneController.text = userProfile['phone_number'] ?? '';
  //         _selectedGender = userProfile['gender'];
  //         _imagePath = userProfile['profile_image_url'] ?? '';
  //         print("objectss;");
  //         print(_firstNameController.text);
  //       });
  //     });
  //   }
  // }

  // void _fetchUserProfile() async {
  //   final data = await ref.read(userControllerProvider).getUserProfile();
  //   final user = data['user'];
  //   final userProfile = user['user'] ?? {};

  //   setState(() {
  //     _firstNameController.text = userProfile['first_name'] ?? '';
  //     _middleNameController.text = userProfile['middle_name'] ?? '';
  //     _lastNameController.text = userProfile["last_name"] ?? '';
  //     _phoneController.text = userProfile['phone_number'] ?? '';
  //     _emailController.text = userProfile['email'] ?? '';
  //     _bioController.text = userProfile['bio'] ?? '';
  //     _selectedGender = userProfile['gender'] ?? '';
  //     _imagePath = userProfile['profile_image_url'] ?? '';
  //     _isLoading = false; // Mark as loaded
  //   });
  //   print(_firstNameController.text);
  // }

  @override
  Widget build(BuildContext context) {
    print("Rebuilding UI...");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loader while fetching data
          : SingleChildScrollView(
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
                                  backgroundImage: _imagePath != null &&
                                          _imagePath!.isNotEmpty
                                      ? FileImage(File(_imagePath!))
                                          as ImageProvider
                                      : (_fetchedImagePath != null &&
                                              _fetchedImagePath!.isNotEmpty
                                          ? NetworkImage(_fetchedImagePath!)
                                          : AssetImage(
                                                  'assets/images/avatar.png')
                                              as ImageProvider),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () => pickImage(),
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
                                print(_middleNameController);
                                if (value == null || value.isEmpty) {
                                  return 'Please enter middle name';
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
                                  return 'Please enter last name';
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
                                DropdownMenuItem(
                                    value: 'male', child: Text('Male')),
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
                                }

                                // Case 1: Number starts with "+"
                                if (value.startsWith('+')) {
                                  if (value.length != 13) {
                                    return 'Phone number must be 13 digits including "+"';
                                  } else if (!RegExp(r'^\+251[0-9]{9}$')
                                      .hasMatch(value)) {
                                    return 'Phone number must start with +251 and have 9 digits after it';
                                  }
                                }
                                // Case 2: Number does NOT start with "+"
                                else {
                                  if (value.length != 10) {
                                    return 'Phone number must be 10 digits';
                                  } else if (!RegExp(r'^(09|07)[0-9]{8}$')
                                      .hasMatch(value)) {
                                    return 'Phone number must start with 09 or 07';
                                  }
                                }

                                return null;
                              },
                              onChanged: (value) {
                                _phoneController.text = value;
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

                            // MultiSelectDropdown(
                            //   labelText: "Select Options",
                            //   prefixIcon: Icons.list,
                            //   items: [
                            //     'Electrician',
                            //     'Plumber',
                            //     'Technician',
                            //     'Welder',
                            //     'Tutor',
                            //     'Carpenter',
                            //     'Mechanic',
                            //     'Cleaner',
                            //     'Gardener',
                            //     'Painter'
                            //   ],

                            //   maxSelection: 3,
                            //   initialValue: _selectedOptions, // Pass the controller
                            //   onSelectionChanged: (selected) {
                            //     setState(() {
                            //       _selectedOptions = selected;
                            //     });
                            //   },
                            // ),
                            SizedBox(height: 20),
                            LargeTextInputField(
                              controller: _bioController,
                              labelText: 'Bio',
                              prefixIcon: Icons.edit,
                              keyboardType: TextInputType.text,
                              maxLines: 5,
                              onChanged: (value) {
                                // Handle bio change
                              },
                            ),
                            SizedBox(height: 20),
                            // Update Button
                            SizedBox(
                                width: double.infinity,
                                child: LargeButton(
                                  text: "Update",
                                  onTap: update,
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
