import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/applied_jobs_card.dart';
import 'package:blaemuya/widgets/job/inprogress_job_card.dart';
import 'package:blaemuya/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:blaemuya/widgets/new_jobs_card.dart';
import 'package:url_launcher/url_launcher.dart';

class InprogressJobs extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        itemCount: 4,
        
        itemBuilder: (context, index) {
          return InprogressJobCard(
  title: "Plumbing",
  urgency: "Urgent",
  time: "2 hr ago",
  distance: "2.5 km",
  description: "Looking for an experienced plumber to fix a leaking pipe.",
  callButton: IconButton(
  icon: Icon(Icons.phone, color: Colors.green),
  onPressed: () async {
    final Uri callUri = Uri.parse('tel:0912345678'); // Replace with the actual number
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      // Handle the error if the URL cannot be launched
      print("Could not launch the phone call.");
    }
  },
),
  DirectionButton: IconButton(
    icon: Icon(Icons.location_on, color: primaryColor),
    onPressed: () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ()), // Replace with actual navigation
      // );
    },
  ),
);

        },
      ),
    );
  }
}
