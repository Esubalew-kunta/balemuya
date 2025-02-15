import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:blaemuya/professional/screens/jobs/job_details.dart';

class ProfessionalNotifications extends StatefulWidget {
  @override
  _ProfessionalNotificationsState createState() =>
      _ProfessionalNotificationsState();
}

class _ProfessionalNotificationsState extends State<ProfessionalNotifications> {
  List<Map<String, String>> notifications = [
    {
      "type": "New job posted",
      "distance": "3",
      "category": "Carpenter nedded",
      "date": "5 mins ago",
      "imageUrl": "https://randomuser.me/api/portraits/women/1.jpg",
    },
    {
      "type": "New job posted",
      "distance": "5",
      "category": "Electrician nedded",
      "date": "Feb 13, 2025",
      "imageUrl": "https://randomuser.me/api/portraits/women/2.jpg",
    },
    {
      "type": "New job posted",
      "distance": "3",
      "category": "Plumber nedded",
      "date": "4 mins ago",
      "imageUrl": "https://randomuser.me/api/portraits/men/3.jpg",
    },
    {
      "type": "New job posted",
      "distance": "4",
      "category": "Painter nedded",
      "date": "Feb 15, 2025",
      "imageUrl": "https://randomuser.me/api/portraits/women/4.jpg",
    }
  ];

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Notifications', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return _buildNotificationCard(
                      context,
                      notification["type"]!,
                      notification["distance"]!,
                      notification["category"]!,
                      notification["date"]!,
                      notification["imageUrl"]!,
                      index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    String notificationType,
    String distance,
    String category,
    String date,
    String imageUrl, // Employer profile image URL
    int index,
  ) {
    return Slidable(
      key: ValueKey(index),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JobDetails()),
              );
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.open_in_new,
            label: 'View',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              _deleteNotification(index);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        color: Color.fromARGB(255, 202, 201, 201),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Section (Job Details)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notificationType,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  SizedBox(height: 4),
                  Text(
                    "$category  •  $distance km away",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(date,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                ],
              ),

              // Right Section (Employer Profile Picture)
              CircleAvatar(
                radius: 24, // Adjust size as needed
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor:
                    Colors.grey[300], // Fallback color if image fails
              ),
            ],
          ),
        ),
      ),
    );
  }
}
