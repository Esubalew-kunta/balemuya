import 'dart:io';

import 'package:blaemuya/common/screens/setting.dart';
import 'package:blaemuya/features/auth/controller/user_controller.dart';
import 'package:blaemuya/professional/screens/certificate.dart';
import 'package:blaemuya/professional/screens/varified_profile_edit.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfessionalProfile extends ConsumerStatefulWidget {
  const ProfessionalProfile({super.key});

  @override
  ConsumerState<ProfessionalProfile> createState() =>
      _ProfessionalProfileState();
}

class _ProfessionalProfileState extends ConsumerState<ProfessionalProfile> {
  // String? _CertificateImagePath;

  // void update() async {
  //   if (_CertificateImagePath == null) {
  //     print("No certificate image selected.");
  //     return;
  //   }

  //   final updateCertificate = FormData.fromMap(
  //       {'certificate_image': MultipartFile.fromFile(_CertificateImagePath!)});
  //   print('updated one $updateCertificate');

  //   try {
  //     final response = await ref.read(userControllerProvider).updateCertificate(
  //           updatedCertificate: updateCertificate,
  //         );

  //     if (response.statusCode == 201) {
  //       print("Certificate uploaded successfully: ${response.data}");
  //     } else {
  //       print("Failed to upload certificate: ${response.statusMessage}");
  //     }
  //   } catch (e) {
  //     print("Error uploading certificate: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: ref.watch(userControllerProvider).getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}')); // Error handling
          } else if (snapshot.hasData) {
            final data = snapshot.data;

            if (data == null) {
              return Center(child: Text('No data available'));
            }

            // Extract user profile data from the response
            final user = data['user'];
            if (user == null) {
              return Center(child: Text('User data not found'));
            }

            final userProfile =
                user['user'] ?? {}; // This could be a map instead of a string
            ///
            final skillsList =
                user['skills'] is List ? user['skills'] as List<dynamic> : [];
            //address
            final address = user["address"] ?? {};
            //
            print("addss $address");

            final CategoryList = user["categories"] is List
                ? ['categories'] as List<dynamic>
                : [];
            final PortfolioList = user["portfolios"] is List
                ? ['portfolios'] as List<dynamic>
                : [];
            print("portfff $PortfolioList.");

            final List<dynamic> certificatesList = user["certificates"] is List
                ? user["certificates"] as List<dynamic>
                : [];
            print('certf $certificatesList');
            if (userProfile == null) {
              return Center(child: Text('User profile data not found'));
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                                      backgroundImage: NetworkImage(
                                        userProfile['profile_image_url'] ??
                                            '', // Null check for profile image URL
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Name and Unverified Label
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${userProfile['first_name'] ?? '-'} ${userProfile['middle_name'] ?? '-'}', // Null checks for first and last name
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            (userProfile['is_verified'] ??
                                                    false)
                                                ? "Verified"
                                                : "Unverified", // Null check for is_verified (boolean)
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 160,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          infoText(
                                              "Gender",
                                              userProfile['gender'] ??
                                                  '-'), // Null check for gender
                                          const SizedBox(height: 8),
                                          infoText(
                                              "Phone number",
                                              userProfile['phone_number'] ??
                                                  '-'),

                                          //
                                          // Null check for phone_number
                                          infoText(
                                            "Skills",
                                            skillsList.isNotEmpty
                                                ? skillsList
                                                    .map((skill) => (skill[
                                                                'name'] ??
                                                            '-')
                                                        .toString()) // Ensure 'name' is a string
                                                    .where((name) => name
                                                        .isNotEmpty) // Filter out empty names
                                                    .join(", ")
                                                : "-", // Fallback text
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 170,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // addressList

                                          infoText("Address",
                                              address['country'] ?? '-'),
                                          const SizedBox(height: 8),
                                          infoText("Email",
                                              userProfile['email'] ?? '-'),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    infoText(
                                        "Bio",
                                        data['user']?['profile']?['bio'] ??
                                            "-"), // Null check for bio
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
                                        builder: (context) =>
                                            ProfileEdit(userId: user["id"])),
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
                    SizedBox(height: 10),
                    CertificateWidget(certificatesList: certificatesList),
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                    IDImagesSection(context),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  // Helper method to style text fields
  Widget infoText(
    String title,
    String value, {
    int maxLines = 1, // Default to 1 line if not provided
    TextOverflow overflow =
        TextOverflow.ellipsis, // Default to ellipsis if not provided
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: const Color.fromARGB(137, 0, 0, 0),
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          maxLines: maxLines, // Apply maxLines
          overflow: overflow, // Apply overflow
        ),
      ],
    );
  }

  // Widget CertificateWidget({required List<dynamic> certificatesList}) {
  //   Future<void> pickCertificateImage() async {
  //     print("Picking image...");
  //     final pickedFile =
  //         await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (pickedFile != null) {
  //       setState(() {
  //         _CertificateImagePath = pickedFile.path;
  //       });
  //       print("Image selected: ${pickedFile.path}");
  //       update(); // Trigger upload
  //     } else {
  //       print("No image selected");
  //     }
  //   }

  //   print("Certificates List: $certificatesList"); // Debugging print

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             "Certificates",
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //           ),
  //           InkWell(
  //             onTap: () => pickCertificateImage(),
  //             child: CircleAvatar(
  //               radius: 20,
  //               backgroundColor: primaryColor,
  //               child: Icon(Icons.add, color: Colors.white),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 8),
  //       certificatesList.isEmpty
  //           ? Text(
  //               "No certificates uploaded.",
  //               style: TextStyle(color: Colors.black54),
  //             )
  //           : ListView.builder(
  //               shrinkWrap: true,
  //               physics: NeverScrollableScrollPhysics(),
  //               itemCount: certificatesList.length,
  //               itemBuilder: (context, index) {
  //                 // Ensure data is a Map
  //                 if (certificatesList[index] is Map<String, dynamic>) {
  //                   final certificate =
  //                       certificatesList[index] as Map<String, dynamic>;

  //                   // Extract title and image URL
  //                   final title = certificate['title'] ?? '-';
  //                   final imageUrl = certificate['certificate_image_url'] ?? '';

  //                   return Card(
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             title,
  //                             style: TextStyle(
  //                                 fontSize: 16, fontWeight: FontWeight.bold),
  //                           ),
  //                           const SizedBox(height: 4),
  //                           if (imageUrl.isNotEmpty)
  //                             ClipRRect(
  //                               borderRadius: BorderRadius.circular(
  //                                   8), // Optional rounded corners
  //                               child: AspectRatio(
  //                                 aspectRatio: 16 /
  //                                     9, // Adjust for different aspect ratios
  //                                 child: Image.network(
  //                                   imageUrl,
  //                                   width: double.infinity,
  //                                   fit: BoxFit.cover,
  //                                   errorBuilder: (context, error, stackTrace) {
  //                                     return Text("Failed to load image.");
  //                                   },
  //                                 ),
  //                               ),
  //                             ),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 } else {
  //                   return Text("Invalid certificate data.");
  //                 }
  //               },
  //             ),
  //     ],
  //   );
  // }

  List<String> IDImages = [];

  Widget IDImagesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Upload ID (Front & Back)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () async {
                if (IDImages.length >= 2) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            "You can only upload 2 images (Front & Back)")),
                  );
                  return;
                }

                final ImagePicker picker = ImagePicker();
                final XFile? pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  IDImages.add(pickedFile.path);
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
        IDImages.length < 2
            ? Text("Please upload both front and back images.",
                style: TextStyle(color: Colors.red))
            : const SizedBox(),
        const SizedBox(height: 8),
        IDImages.isEmpty
            ? Text("No ID images uploaded.",
                style: TextStyle(color: Colors.black54))
            : SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: IDImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(IDImages[index]),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                IDImages.removeAt(index);
                              },
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.close,
                                    color: Colors.white, size: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
//   List<String> previousWorkImages =
//       []; // List to store selected certificate images

//   Widget previousWorkSection(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Preious works",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             InkWell(
//               onTap: () async {
//                 final ImagePicker picker = ImagePicker();
//                 final XFile? pickedFile =
//                     await picker.pickImage(source: ImageSource.gallery);
//                 if (pickedFile != null) {
//                   certificateImages.add(pickedFile.path);
//                 }
//               },
//               child: CircleAvatar(
//                 radius: 20,
//                 backgroundColor: primaryColor,
//                 child: Icon(Icons.add, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         certificateImages.isEmpty
//             ? Text("No certificates uploaded.",
//                 style: TextStyle(color: Colors.black54))
//             : SizedBox(
//                 height: 80,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: certificateImages.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 8.0),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.file(
//                           File(certificateImages[index]),
//                           width: 80,
//                           height: 80,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//       ],
//     );
//   }
// }
