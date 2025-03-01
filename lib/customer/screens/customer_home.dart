import 'package:blaemuya/customer/screens/customer_jobs_list.dart';
import 'package:blaemuya/customer/screens/jobs/post_job.dart';
import 'package:blaemuya/customer/screens/jobs/nearby_professionals_map.dart';
import 'package:blaemuya/features/auth/controller/user_controller.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/slider_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerHome extends ConsumerStatefulWidget {
  const CustomerHome({super.key});

  @override
  ConsumerState<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends ConsumerState<CustomerHome> {
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
        backgroundColor: primaryColor,
        elevation: 0,
        leading: FutureBuilder(
          future: ref.watch(userControllerProvider).getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 255, 105, 105),
                  child: Icon(Icons.home, color: Colors.white),
                ),
              );
            }

            // Extract user data safely
            final userData = snapshot.data?['user']?['user'];
            if (userData == null) {
              return const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.error, color: Color.fromARGB(255, 2, 255, 36)),
                ),
              );
            }

            final profileImageUrl = userData['profile_image_url'];
            return Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: CircleAvatar(
                backgroundImage: profileImageUrl != null
                    ? NetworkImage(profileImageUrl)
                    : const AssetImage('assets/images/avator.png')
                        as ImageProvider,
              ),
            );
          },
        ),
        title: FutureBuilder(
          future: ref.watch(userControllerProvider).getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text(
                'Hi...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }

            final userData = snapshot.data?['user']?['user'];
            final firstName = userData?['first_name'] ?? 'User';

            return Text(
              'Hi $firstName',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        ),
        actions: const [
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
       body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //location
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: primaryColor),
                    const SizedBox(width: 8),
                    const Text('Bahir Dar, Amhara'),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.refresh, size: 16),
                  label: Text('Update location'),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
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
            HeroSection(),
            SizedBox(height: 16),

            // Display only categories that have matching search results
            for (var category in categories.keys)
              if (categories[category]!.any((service) =>
                  service["title"]!.toLowerCase().contains(searchQuery)))
                _buildCategorySection(category),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobPostPage(),
            ),
          );
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Category Section Widget
  Widget _buildCategorySection(String title) {
    List<Map<String, dynamic>> services = categories[title]!;
    List<Map<String, dynamic>> filteredServices = services
        .where(
            (service) => service["title"]!.toLowerCase().contains(searchQuery))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title with "See All"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerJobsList()),
                );
              },
              child: Text("See All"),
            ),
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
                  MaterialPageRoute(
                      builder: (context) =>
                          NearbyProfessionalsMap(title: service["title"]!)),
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
                    Text(service["title"]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
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

class HeroSection extends StatelessWidget {
  final List<String> images = [
    'assets/images/maintainance.jpg',
    'assets/images/mechanic.jpg',
    'assets/images/electrician.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0, // Set the height of the carousel
        autoPlay: true, // Enable automatic sliding
        autoPlayInterval: Duration(seconds: 3), // Set the interval time
        enlargeCenterPage: true, // Highlight the current image
        viewportFraction: 0.87, // Show one image at a time
      ),
      items: images.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    const Positioned(
                      top: 8,
                      left: 8,
                      child: Text(
                        'Find the best Nearby \nProfessiolnals',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          fontSize: 25,
                          wordSpacing: 2,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: SliderButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomerJobsList(),
                            ),
                          );
                        },
                        text: 'Find nearby experts',
                        isSelected: false,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
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

// // See All Page
// class SeeAllPage extends StatelessWidget {
//   final String title;
//   final List<Map<String, dynamic>> services;

//   SeeAllPage({required this.title, required this.services});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: ListView.builder(
//         padding: EdgeInsets.all(16),
//         itemCount: services.length,
//         itemBuilder: (context, index) {
//           var service = services[index];
//           return ListTile(
//             leading: Icon(service["icon"], color: primaryColor),
//             title: Text(service["title"]!,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         JobDetailPage(title: service["title"]!)),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
