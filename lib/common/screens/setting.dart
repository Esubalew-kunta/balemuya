import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/common/screens/login.dart';
import 'package:blaemuya/common/screens/provacy_policy.dart';
import 'package:blaemuya/common/screens/terms_and_conditions.dart';
import 'package:blaemuya/features/auth/controller/auth_controller.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:blaemuya/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Info Section
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 236, 215, 253),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('INFO', style: TextStyle(fontWeight: FontWeight.bold)),
                ListTile(
                  title: Text('Privacy Policy'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigator.pushNamed(context, '/privacy_policy');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicy(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('Terms & Conditions'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigator.pushNamed(context, '/terms_conditions');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TermsAndPolicyPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Account Section
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 236, 215, 253),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account', style: TextStyle(fontWeight: FontWeight.bold)),
                ListTile(
                  title: Text('Log Out'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // Prevent user from dismissing
                      builder: (context) =>
                          Center(child: CircularProgressIndicator()),
                    );

                    final response =
                        await ref.read(authControllerProvider).logout();

                    // Close the loading dialog
                    Navigator.of(context).pop();

                    // Show success message
                    showCustomSnackBar(
                      context,
                      title: 'Logout',
                      message: response,
                      type: AnimatedSnackBarType.success,
                    );

                    // Navigate to login screen and clear navigation stack
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
