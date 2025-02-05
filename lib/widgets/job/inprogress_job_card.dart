import 'package:blaemuya/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InprogressJobCard extends StatelessWidget {
  final String title;
  final String urgency;
  final String time;
  final String distance;
  final String description;
   final Widget callButton; // Phone number for calling
   final Widget DirectionButton; // Function to navigate

  InprogressJobCard({
    required this.title,
    required this.urgency,
    required this.time,
    required this.distance,
    required this.description,
    required this.callButton,
    required this.DirectionButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ensure full width
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    urgency,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 228, 143, 137),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(time, style: TextStyle(fontSize: 12, color: Colors.grey)),
                  SizedBox(width: 16),
                  Text(distance, style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              SizedBox(height: 8),
              Text(description, style: TextStyle(fontSize: 14)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Navigation Icon (Redirects to another page)
                      SizedBox(height: 8),
            Align(alignment: Alignment.centerRight, child: DirectionButton),
                      // Call Icon (Launches phone dialer)
                     SizedBox(height: 8),
            Align(alignment: Alignment.centerRight, child: callButton),
                    ],
                  ),
                 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
