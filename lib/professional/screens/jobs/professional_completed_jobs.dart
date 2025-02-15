import 'package:blaemuya/customer/screens/jobs/jobs_card/completed_job_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProfessionalCompletedJobs extends StatefulWidget {
  @override
  _ProfessionalCompletedJobsState createState() =>
      _ProfessionalCompletedJobsState();
}

class _ProfessionalCompletedJobsState extends State<ProfessionalCompletedJobs> {
  final List<Map<String, dynamic>> candidates = [
    {
      'name': 'Abebe K.',
      'imageUrl': 'https://www.example.com/image1.jpg',
      'rating': 4.5,
      'distance': '5 km away',
      'categories': 'Customer',
    },
    {
      'name': 'Abel S.',
      'imageUrl': 'https://www.example.com/image2.jpg',
      'rating': 4.2,
      'distance': '2 km away',
      'categories': 'Customer',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: ListView.builder(
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          var candidate = candidates[index];
          return CompletedJobCard(
            name: candidate['name'],
            imageUrl: candidate['imageUrl'],
            rating: candidate['rating'],
            categories: candidate['categories'],
            OnRateProfessional: () {
              // Code to navigate or open the rate dialog here
              _showRateDialog(context);
            },
          );
        },
      ),
    );
  }

  void _showRateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        double userRating = 0.0;
        TextEditingController commentController = TextEditingController();

        return AlertDialog(
          title: Text("Rate Customer"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: userRating,
                minRating: 1,
                itemSize: 40,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  userRating = rating;
                },
              ),
              SizedBox(height: 12),
              TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'Enter your comment',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Handle the rating and comment submission
                print("Rating: $userRating");
                print("Comment: ${commentController.text}");
                Navigator.pop(context);
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
