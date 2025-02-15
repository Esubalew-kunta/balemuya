import 'package:blaemuya/customer/screens/jobs/customer_notification_profile_view.dart';
import 'package:blaemuya/customer/screens/jobs/nearby_professional_profile_detail.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:blaemuya/professional/screens/jobs/job_details.dart';

class CustomerNotifications extends StatefulWidget {
  @override
  _CustomerNotificationsState createState() =>
      _CustomerNotificationsState();
}

class _CustomerNotificationsState extends State<CustomerNotifications> {
  List<Map<String, String>> notifications = [
    {
      "type": "job request accepted",
      "distance": "3",
      "category": "Carpenter ",
      "date": "5 mins ago",
      "imageUrl": "https://randomuser.me/api/portraits/women/1.jpg",
    },
    // {
    //   "type": "3 candidates applied ot the job",
    //   "distance": "",
    //   "category": "Electrician ",
    //   "date": "Feb 13, 2025",
    //   "imageUrl": "https://randomuser.me/api/portraits/women/2.jpg",
    // },
    
  
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
        title: CustomText("Notifications"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                MaterialPageRoute(builder: (context) => CustomerNotificationProfileView()),
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
