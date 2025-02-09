import 'dart:io';

import 'package:blaemuya/common/screens/setting.dart';
import 'package:blaemuya/customer/screens/customer_profile_edit.dart';
import 'package:blaemuya/professional/screens/varified_profile_edit.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

class CustomerProfile extends StatelessWidget {
  final String profileImageUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9SRRmhH4X5N2e4QalcoxVbzYsD44C-sQv-w&s"; // Replace with actual image URL
  final String name = "Abebe Kebede";
  final String phone = "+251966042929";
  final String email = "abc@gmail.com";
  final String gender = "Male";
  final String address = "Addis Ababa";

  CustomerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: CustomText("Profile"),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: primaryColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Profile Image
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  CachedNetworkImageProvider(profileImageUrl),
                            ),
                            const SizedBox(width: 12),
                            // Name and Unverified Label
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Details (Gender, Address, Phone, Email)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                infoText("Gender", gender),
                                const SizedBox(height: 8),
                                infoText("Phone number", phone),
                                
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                infoText("Address", address),
                                const SizedBox(height: 8),
                                infoText("Email", email),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Edit Button (Top Right)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          // Navigate to edit profile screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomerProfileEdit(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey[300],
                          child: Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Helper method to style text fields
  Widget infoText(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  List<String> certificateImages =
      []; // List to store selected certificate images

  Widget certificatesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Certificates",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  certificateImages.add(pickedFile.path);
                }
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: primaryColor,
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        certificateImages.isEmpty
            ? Text("No certificates uploaded.",
                style: TextStyle(color: Colors.black54))
            : SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: certificateImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(certificateImages[index]),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
