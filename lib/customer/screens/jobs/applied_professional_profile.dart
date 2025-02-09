import 'dart:io';

import 'package:blaemuya/customer/screens/jobs/post_job.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/large_button.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class applied_professional_profile extends StatelessWidget {
  final String profileImageUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9SRRmhH4X5N2e4QalcoxVbzYsD44C-sQv-w&s"; // Replace with actual image URL
  final String name = "Abebe Kebede";
  final String phone = "+251966042929";
  final String email = "abc@gmail.com";
  final String gender = "Male";
  final String address = "Addis Ababa";
  final String Skills = "Plumbing";
  final String Bio = "I am skilled plumber with 5 years of experience";

  applied_professional_profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
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
                child: Column(
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
                        // Name and Verified Label
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
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "verified",
                                style: TextStyle(
                                  color: Colors.green[900],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
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
                            infoText("Skills", Skills),
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
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        infoText("Bio", Bio),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            certificatesSection(context),
            SizedBox(height: 10),
            previousWorkSection(context),
            SizedBox(height: 15,),
            

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
        Text(
          "Certificates",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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


  List<String> previousWorkImages =
      []; // List to store selected certificate images

  Widget previousWorkSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Previous Works",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        previousWorkImages.isEmpty
            ? Text("No previous works uploaded.",
                style: TextStyle(color: Colors.black54))
            : SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: previousWorkImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(previousWorkImages[index]),
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
