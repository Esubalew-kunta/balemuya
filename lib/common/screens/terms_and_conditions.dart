import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:flutter/material.dart';

class TermsAndPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Terms and Conditions"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1. Platform Usage\n\n'
              'Balemuya is a platform connecting service providers (e.g., plumbers, carpenters, electricians) with customers. '
              'By using the platform, users agree to use the service for lawful purposes only. '
              'Service providers must be certified, skilled, and qualified to perform their services, ensuring that the services offered meet the platform\'s standards. '
              'Customers must provide accurate information when requesting services and ensure the address and payment details are correct.\n\n'
              '2. Service Agreements\n\n'
              'Any service agreement between a customer and a service provider is directly between the two parties. '
              'Balemuya is not responsible for the outcomes of these agreements. '
              'Service providers are responsible for the quality and timely delivery of services, while customers are responsible for paying for services rendered.\n\n'
              '3. Payment and Fees\n\n'
              'Payments for services are to be made through the platform\'s integrated payment system. '
              'Balemuya may charge a service fee to service providers for each transaction, and the service provider agrees to pay this fee for the use of the platform.\n\n'
              '4. User Conduct\n\n'
              'Users are prohibited from posting inappropriate, illegal, or harmful content on the platform. This includes offensive language, discriminatory behavior, or fraudulent activity. '
              'Both service providers and customers must respect the rights of others, including respecting appointments and ensuring a safe environment.\n\n'
              '5. Privacy and Data Protection\n\n'
              'Balemuya respects user privacy. Any personal information provided by users is protected in accordance with the platform\'s privacy policy. '
              'The platform may collect and store user data for the purposes of improving services, processing payments, and communicating with users.\n\n'
              '6. Account Management\n\n'
              'Users are responsible for maintaining the security and confidentiality of their account login details. '
              'The platform has the right to suspend or terminate accounts that violate these Terms and Conditions.\n\n'
              '7. Platform Modifications\n\n'
              'Balemuya reserves the right to modify or update these Terms and Conditions at any time. Users will be notified of significant changes, and continued use of the platform will be deemed as acceptance of the updated terms.\n\n',
              style: TextStyle(fontSize: 16),
            ),
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
