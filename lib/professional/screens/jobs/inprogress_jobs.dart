import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/professional/screens/jobs/inprogress_jobs_detail.dart';
import 'package:blaemuya/professional/screens/jobs/maps.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/applied_jobs_card.dart';
import 'package:blaemuya/widgets/job/inprogress_job_card.dart';
import 'package:blaemuya/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:blaemuya/widgets/new_jobs_card.dart';
import 'package:permission_handler/permission_handler.dart';
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
   onPressed:() async {
              final Uri callUri = Uri(scheme: 'tel', path: '+251912345678'); 
              if (await canLaunchUrl(callUri)) {
                await launchUrl(callUri);
              } else {
                print("Could not launch the dialer.");
              }
            },
),
  DirectionButton: IconButton(
    icon: Icon(Icons.location_on, color: primaryColor),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Maps()), 
      );
    },
  ), detailButton: TextButton(
                    onPressed: () {
                      Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => InprogressJobsDetail()), 
      );
                    },
                    child:
                        Text('Details', style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 131, 116, 116))),
                  ), 
);

        },
      ),
    );
  }
}
