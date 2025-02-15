import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Privacy Policy"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1. Information We Collect\n\n'
              '• Personal Information: When you create an account, we may collect personal details such as your name, email, phone number, and address.\n\n'
              '• Service Data: We collect data related to services requested and provided, including service details, payment records, and communication history.\n\n'
              '• Device and Usage Information: We collect information related to how you interact with the platform, including device information, IP address, and usage patterns.\n\n'
              '2. How We Use Your Information\n\n'
              '• To process your service requests and manage your account.\n\n'
              '• To facilitate payment transactions and confirm service bookings.\n\n'
              '• To communicate important updates, promotions, and service-related information.\n\n'
              '3. Data Security\n\n'
              '• We implement security measures to protect your personal information. However, no method of transmission over the internet is completely secure, and we cannot guarantee absolute security.\n\n'
              '4. Third-Party Services\n\n'
              '• We do not share your personal information with third parties except as necessary to provide our services or when required by law.\n\n'
              '5. Changes to the Privacy Policy\n\n'
              '• We may update this Privacy Policy from time to time, and any changes will be posted on this page with the updated date.\n\n',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
