import 'package:flutter/material.dart';

class PostedJobCard extends StatelessWidget {
  final String title;
  final String urgency;
  final String time;
  final String date;
  final String description;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  PostedJobCard({
    required this.title,
    required this.urgency,
    required this.time,
    required this.date,
    required this.description,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    children: [
                      Text(urgency, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert), // Three vertical dots
                        onSelected: (String choice) {
                          if (choice == 'Edit') {
                            onEdit();
                          } else if (choice == 'Delete') {
                            onDelete();
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'Edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'Delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Delete'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(time, style: TextStyle(fontSize: 12, color: Colors.grey)),
                  SizedBox(width: 16),
                  Text(date, style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              SizedBox(height: 8),
              Text(description, style: TextStyle(fontSize: 14)),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
