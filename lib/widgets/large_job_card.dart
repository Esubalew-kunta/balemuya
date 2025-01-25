


import 'package:flutter/material.dart';

class LargeJobCard extends StatelessWidget {
  final String title;
  final String urgency;
  final String time;
  final String distance;
  final String description;
  final Widget actionButton;

  LargeJobCard({
    required this.title,
    required this.urgency,
    required this.time,
    required this.distance,
    required this.description,
    required this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      child:Card(
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
                Text(urgency, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
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
            Align(alignment: Alignment.centerRight, child: actionButton),
          ],
        ),
      ),
    ) ,
    );
  }
}
