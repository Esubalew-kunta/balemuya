import 'package:blaemuya/customer/screens/jobs/edit_job.dart';
import 'package:flutter/material.dart';
import 'package:blaemuya/customer/screens/jobs/jobs_card/posted_job_card.dart';

class PostedJobs extends StatefulWidget {
  @override
  _PostedJobsState createState() => _PostedJobsState();
}

class _PostedJobsState extends State<PostedJobs> {
  List<Map<String, String>> jobs = [
    {
      "title": "Plumbing repair",
      "time": "2 hr ago",
      "urgency": "Urgent",
      "date": "20/2/2025",
      "description":
          "Experienced plumber needed for immediate repair of a leaking pipe in a residential area. Tools and materials provided on-site.",
    },
    {
      "title": "Electrician",
      "time": "5 hr ago",
      "urgency": "21/2/2025",
      "date": "20/2/2025",
      "description":
          "Looking for an experienced electrician to install lighting fixtures in a commercial building.",
    },
    {
      "title": "Carpenter",
      "time": "1 day ago",
      "urgency": "21/2/2025",
      "date": "20/2/2025",
      "description":
          "Need a carpenter to fix wooden cabinets in a residential home. Must have own tools.",
    },
    {
      "title": "Plumbing repair",
      "time": "2 hr ago",
      "urgency": "Urgent",
      "date": "20/2/2025",
      "description":
          "Experienced plumber needed for immediate repair of a leaking pipe in a residential area. Tools and materials provided on-site.",
    },
    {
      "title": "Electrician",
      "time": "5 hr ago",
      "urgency": "21/2/2025",
      "date": "20/2/2025",
      "description":
          "Looking for an experienced electrician to install lighting fixtures in a commercial building.",
    },
    {
      "title": "Carpenter",
      "time": "1 day ago",
      "urgency": "21/2/2025",
      "date": "20/2/2025",
      "description":
          "Need a carpenter to fix wooden cabinets in a residential home. Must have own tools.",
    },
  ];

  // Delete job function
  void _deleteJob(int index) {
    setState(() {
      jobs.removeAt(index);
    });
  }

  // Edit job function (For now, it just prints. You can navigate to an edit page)
  void _editJob(int index) {
    print("Editing job: ${jobs[index]["title"]}");
    // You can navigate to an edit screen here
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditPostedJob(job: jobs[index])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          return PostedJobCard(
            title: jobs[index]["title"]!,
            urgency: jobs[index]["urgency"]!,
            time: jobs[index]["time"]!,
            date: jobs[index]["date"]!,
            description: jobs[index]["description"]!,
            onEdit: () => _editJob(index), 
            onDelete: () => _deleteJob(index), 
          );
        },
      ),
    );
  }
}
