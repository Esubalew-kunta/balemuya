import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:blaemuya/widgets/slider_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';



class CustomerJobsList extends StatefulWidget {
  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerJobsList> {
  String searchQuery = "";
   final Map<String, List<Map<String, dynamic>>> categories = {
    "Maintenance": [
      {"title": "Electrician", "icon": Icons.electrical_services},
      {"title": "Plumber", "icon": Icons.plumbing},
      {"title": "Painter", "icon": Icons.format_paint},
    ],
    "Home Renovation": [
      {"title": "Carpenter", "icon": Icons.construction},
      {"title": "Mason", "icon": Icons.foundation},
      {"title": "Interior Designer", "icon": Icons.brush},
    ],
    "Domestic Help": [
      {"title": "House Cleaner", "icon": Icons.cleaning_services},
      {"title": "Cook", "icon": Icons.restaurant},
      {"title": "Babysitter", "icon": Icons.child_care},
    ],
    "Car Repair": [
      {"title": "Mechanic", "icon": Icons.car_repair},
      {"title": "Tire Repair", "icon": Icons.tire_repair},
      {"title": "Car Electrician", "icon": Icons.battery_charging_full},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: CustomText("Serices"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            // Search Bar
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: "Find your favourite services",
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 16),
                   //slider Section
     
         SizedBox(height: 16),
         
            // Display only categories that have matching search results
            for (var category in categories.keys)
              if (categories[category]!
                  .any((service) => service["title"]!.toLowerCase().contains(searchQuery)))
                _buildCategorySection(category),
          ],
        ),
      ),

    );
  }

 // Category Section Widget
  Widget _buildCategorySection(String title) {
    List<Map<String, dynamic>> services = categories[title]!;
    List<Map<String, dynamic>> filteredServices = services
        .where((service) => service["title"]!.toLowerCase().contains(searchQuery))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title with "See All"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.2,
          ),
          itemCount: filteredServices.length,
          itemBuilder: (context, index) {
            var service = filteredServices[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JobDetailPage(title: service["title"]!)),
                );
              },
              child: Card(
                elevation: 5,
                shadowColor: Colors.grey,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(service["icon"], size: 40, color: Colors.indigo),
                    SizedBox(height: 8),
                    Text(service["title"]!, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 16),
      ],
    );
  }

}



// Job Detail Page
class JobDetailPage extends StatelessWidget {
  final String title;
  JobDetailPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          "You selected: $title",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}