import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AppliedCandidatesCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double rating;
  final String distance;
  final String categories;
  final VoidCallback onImageTap; // Updated to accept a VoidCallback

  AppliedCandidatesCard({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.distance,
    required this.categories,
    required this.onImageTap, // Accepting onImageTap as a parameter
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Customer Image
            GestureDetector(
              onTap: onImageTap, // Image tap will trigger onImageTap callback
              child: ClipRRect(
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
            ),
            SizedBox(width: 12), // Spacing between image and text

            // Name and Rating
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
                    "$categories ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w100,
                      color: const Color.fromARGB(255, 83, 87, 92),
                    ),
                  ),
                ],
              ),
            ),

            // Address and People Hired
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

            // Overflow menu with 3 dots and "Accept" option
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'accept') {
                  // Handle the accept button action here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Accepted!')),
                  );
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  value: 'accept',
                  child: Text('Accept'),
                ),
              ],
              child: Icon(
                Icons.more_vert,
                color: Colors.black,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
