import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RequestedProfessionalsCard extends StatelessWidget {
  final String title;
  final String urgency;
  final String time;
  final String date;
  final String description;
  final String name;
  final String imageUrl;
  final double rating;
  final String distance;
  final String categories;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  RequestedProfessionalsCard({
    required this.title,
    required this.urgency,
    required this.time,
    required this.date,
    required this.description,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.distance,
    required this.categories,
    required this.onEdit,
    required this.onDelete, required professionalImageUrl, required professionalRating, required professionalDistance, required professionalCategories, required professionalName,
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
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          categories,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                            color: Color.fromARGB(255, 83, 87, 92),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        distance,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 4),
                      RatingBarIndicator(
                        rating: rating,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 16,
                      ),
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
