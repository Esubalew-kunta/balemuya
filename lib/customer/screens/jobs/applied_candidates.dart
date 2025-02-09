import 'package:blaemuya/customer/screens/jobs/applied_professional_profile.dart';
import 'package:blaemuya/customer/screens/jobs/edit_job.dart';
import 'package:blaemuya/customer/screens/jobs/jobs_card/applied_candidates_card.dart';
import 'package:flutter/material.dart';
import 'package:blaemuya/customer/screens/jobs/jobs_card/posted_job_card.dart';

class AppliedCandidatesList extends StatefulWidget {
  @override
  _AppliedCandidatesListState createState() => _AppliedCandidatesListState();
}

class _AppliedCandidatesListState extends State<AppliedCandidatesList> {
  final List<Map<String, dynamic>> candidates = [
    {
      'name': 'Abebe K.',
      'imageUrl': 'https://www.example.com/image1.jpg',
      'rating': 4.5,
      'distance': '5 km away',
      'categories': 'electrician',
    },
    {
      'name': 'Abel S.',
      'imageUrl': 'https://www.example.com/image2.jpg',
      'rating': 4.2,
      'distance': '2 km away',
      'categories': 'Plumber',
    },
    
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: candidates.length,
      itemBuilder: (context, index) {
        var candidate = candidates[index];
        return AppliedCandidatesCard(
          name: candidate['name'],
          imageUrl: candidate['imageUrl'],
          rating: candidate['rating'],
          distance: candidate['distance'],
          categories: candidate['categories'],
           onImageTap: () {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => applied_professional_profile(), 
      ),
    );
  },
        );
      },
    );
  }
}


