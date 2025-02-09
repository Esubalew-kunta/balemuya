import 'package:blaemuya/customer/screens/jobs/edit_job.dart';
import 'package:blaemuya/customer/screens/jobs/jobs_card/requested_professionals_card.dart';
import 'package:flutter/material.dart';

class RequestedProfessionals extends StatefulWidget {
  @override
  _RequestedProfessionalsState createState() => _RequestedProfessionalsState();
}

class _RequestedProfessionalsState extends State<RequestedProfessionals> {
  List<Map<String, dynamic>> jobs = [
    {
      "title": "Plumbing repair",
      "time": "2 hr ago",
      "urgency": "Urgent",
      "date": "20/2/2025",
      "description":
          "Experienced plumber needed for immediate repair of a leaking pipe in a residential area. Tools and materials provided on-site.",
      "name": "John Doe",
      "imageUrl": "https://example.com/profile1.jpg", // Replace with actual image URL
      "rating": 4.5,
      "distance": "2 km away",
      "categories": "Plumbing",
    },
    {
      "title": "Electrician",
      "time": "5 hr ago",
      "urgency": "21/2/2025",
      "date": "20/2/2025",
      "description":
          "Looking for an experienced electrician to install lighting fixtures in a commercial building.",
      "name": "Jane Smith",
      "imageUrl": "https://example.com/profile2.jpg", // Replace with actual image URL
      "rating": 4.8,
      "distance": "5 km away",
      "categories": "Electrical Work",
    },
    {
      "title": "Carpenter",
      "time": "1 day ago",
      "urgency": "21/2/2025",
      "date": "20/2/2025",
      "description":
          "Need a carpenter to fix wooden cabinets in a residential home. Must have own tools.",
      "name": "Michael Brown",
      "imageUrl": "https://example.com/profile3.jpg", // Replace with actual image URL
      "rating": 4.3,
      "distance": "3 km away",
      "categories": "Carpentry",
    },
  ];

  // Delete job function
  void _deleteJob(int index) {
    setState(() {
      jobs.removeAt(index);
    });
  }

  // Edit job function (Navigates to the edit page)
  void _editJob(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPostedJob(job: jobs[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          return RequestedProfessionalsCard(
             title: 'Plumbing', 
            urgency: 'Urgent',
            time: '2 hr ago',
            date: '20/2/2025',
            description:
                'Experienced plumber needed for immediate repair of a leaking pipe in a residential area. Tools and materials provided on-site.',
            name: 'John Doe',
            imageUrl: 'https://example.com/profile1.jpg', 
            rating: 4.5,
            distance: '2 km away',
            categories: 'Plumbing',
              professionalRating: null, 
            professionalDistance: null,
             professionalCategories: null,
              professionalName: null,
            onEdit: () => _editJob(index),
            onDelete: () => _deleteJob(index), professionalImageUrl: null, 
          
          );
        },
      ),
    );
  }
}
