import 'package:blaemuya/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InprogressJobCard extends StatelessWidget {
  final String title;
  final String urgency;
  final String time;
  final String distance;
  final String description;
   final Widget callButton;
   final Widget DirectionButton;
    final Widget detailButton;
     final Widget reportButton;

  InprogressJobCard({
    required this.title,
    required this.urgency,
    required this.time,
    required this.distance,
    required this.description,
    required this.callButton,
    required this.reportButton,
    required this.DirectionButton,
    required this.detailButton,
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
                      Align(alignment: Alignment.centerRight, child: detailButton),
                      Align(alignment: Alignment.centerRight, child: reportButton),
                          ],
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [                 
                      SizedBox(height: 8),
            Align(alignment: Alignment.centerRight, child: DirectionButton),
                     SizedBox(width: 15),
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
