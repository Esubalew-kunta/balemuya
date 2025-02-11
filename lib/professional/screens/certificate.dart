import 'package:blaemuya/features/auth/controller/user_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CertificateWidget extends ConsumerStatefulWidget {
  final List<dynamic> certificatesList;

  const CertificateWidget({super.key, required this.certificatesList});

  @override
  _CertificateWidgetState createState() => _CertificateWidgetState();
}

class _CertificateWidgetState extends ConsumerState<CertificateWidget> {
  String? _certificateImagePath;

  Future<void> pickCertificateImage() async {
    print("Picking image...");
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _certificateImagePath = pickedFile.path;
      });
      print("Image selected: ${pickedFile.path}");
      update(); // Trigger upload
    } else {
      print("No image selected");
    }
  }

  void update() async {
    if (_certificateImagePath == null) {
      print("No certificate image selected.");
      return;
    }

    try {
      final certificateFile =
          await MultipartFile.fromFile(_certificateImagePath!);

      final updateCertificate = FormData.fromMap({
        'certificates': certificateFile,
      });

      print('Updated Certificate: $updateCertificate');

      final response = await ref.read(userControllerProvider).updateCertificate(
            updatedCertificate: updateCertificate,
          );

      if (response.statusCode == 201) {
        print("Certificate uploaded successfully: ${response.data}");
      } else {
        print("Failed to upload certificate: ${response.statusMessage}");
      }
    } catch (e) {
      print("Error uploading certificate: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Certificates List: ${widget.certificatesList}"); // Debugging print

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Certificates",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: pickCertificateImage,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue, // Replace with your primaryColor
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        widget.certificatesList.isEmpty
            ? const Text(
                "No certificates uploaded.",
                style: TextStyle(color: Colors.black54),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.certificatesList.length,
                itemBuilder: (context, index) {
                  if (widget.certificatesList[index] is Map<String, dynamic>) {
                    final certificate =
                        widget.certificatesList[index] as Map<String, dynamic>;

                    final title = certificate['title'] ?? '-';
                    final imageUrl = certificate['certificate_image_url'];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            if (imageUrl != null && imageUrl.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image.network(
                                    imageUrl,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Text(
                                          "Failed to load image.");
                                    },
                                  ),
                                ),
                              ),
                            if (imageUrl == null || imageUrl.isEmpty)
                              const Text("No image available",
                                  style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Text("Invalid certificate data.");
                  }
                },
              ),
      ],
    );
  }
}
