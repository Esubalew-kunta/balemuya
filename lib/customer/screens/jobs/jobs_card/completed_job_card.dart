import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CompletedJobCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double rating;
 
  final String categories;
  final VoidCallback OnRateProfessional;

  CompletedJobCard({
    required this.name,
    required this.imageUrl,
    required this.rating,
 
    required this.categories,
    required this.OnRateProfessional,
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
            GestureDetector(
              onTap: OnRateProfessional,
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
            SizedBox(width: 12),

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

            // Address and Rating
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Text(
                //   distance,
                //   style: TextStyle(
                //     fontSize: 14,
                //     color: Colors.grey[700],
                //   ),
                // ),
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

            // Rate User Button
            TextButton(
              onPressed: () {
                _showRateDialog(context);
              },
              child: const Text(
                "Rate User",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show rating dialog
  void _showRateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        double userRating = 0.0;
        TextEditingController commentController = TextEditingController();

        return AlertDialog(
          title: Text("Rate User"),
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
                // Handle rating submission
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
