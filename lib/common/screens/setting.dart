import 'package:blaemuya/common/screens/login.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);

          },
        ),
        title:CustomText("Setting"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Info Section
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 158, 168, 209),
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
                        builder: (context) => Placeholder(),
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
                        builder: (context) => Placeholder(),
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
              color: const Color.fromARGB(255, 158, 168, 209),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
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
