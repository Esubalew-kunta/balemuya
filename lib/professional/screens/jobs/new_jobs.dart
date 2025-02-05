import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/professional/screens/jobs/job_details.dart';
import 'package:blaemuya/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:blaemuya/widgets/new_jobs_card.dart';

class NewJobs extends StatelessWidget {
  final List<Map<String, String>> jobs = [
    {
      "title": "Plumbing repair",
      "time": "2 hr ago",
      "urgency": "Urgent",
      "distance": "2 Km away",
      "description":
          "Experienced plumber needed for immediate repair of a leaking pipe in a residential area. Tools and materials provided on-site.",
    },
    {
      "title": "Electrician Needed",
      "time": "5 hr ago",
      "urgency": "High Priority",
      "distance": "3 Km away",
      "description":
          "Looking for an experienced electrician to install lighting fixtures in a commercial building.",
    },
    {
      "title": "Carpenter Required",
      "time": "1 day ago",
      "urgency": "Moderate",
      "distance": "4 Km away",
      "description":
          "Need a carpenter to fix wooden cabinets in a residential home. Must have own tools.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          return NewJobsCard(
              title: jobs[index]["title"]!,
              urgency: jobs[index]["urgency"]!,
              time: jobs[index]["time"]!,
              distance: jobs[index]["distance"]!,
              description: jobs[index]["description"]!,
              ///////////////////////
              actionButton: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              JobDetails(), 
                        ),
                      );
                
                },
                child: Text(
                  'Apply',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w300),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(40, 80, 200, 120),
                  side: BorderSide(
                      color: const Color.fromARGB(100, 80, 200, 120)),
                  minimumSize: Size(100, 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.zero,
                ),
              )

              );
        },
      ),
    );
  }
}
