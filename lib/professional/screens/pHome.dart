import 'package:blaemuya/features/auth/controller/auth_controller.dart';
import 'package:blaemuya/widgets/large_job_card.dart';
import 'package:blaemuya/widgets/new_jobs_card.dart';
import 'package:blaemuya/widgets/slider_button.dart';
import 'package:blaemuya/widgets/small_button_bright.dart';
import 'package:blaemuya/widgets/small_button_dark.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfessionalHome extends ConsumerStatefulWidget {
  const ProfessionalHome({super.key});

  @override
  ConsumerState<ProfessionalHome> createState() => _ProfessionalHomeState();
}
class _ProfessionalHomeState extends ConsumerState<ProfessionalHome> {
   

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(
              left:
                  8.0), // Adds padding to the left to move the image to the right
          child: CircleAvatar(
            backgroundImage:AssetImage(
              'assets/images/mech.jpg',
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const Text('Hi Abebe  ',
                style: TextStyle(color: Colors.white, fontSize: 13)),
            DropdownStatus(),
          ],
        ),
        actions: const [
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Location Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.blue[900]),
                  const SizedBox(width: 8),
                  const Text('Bahir Dar, poly'),
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

          //slider Section
          HeroSection(),

          SizedBox(height: 16),

          // New Jobs Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('New jobs',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton.icon(
                onPressed: () {},
                label: Text('See all'),
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                NewJobsCard(
                  title: 'Plumbing repair',
                  urgency: 'Urgent',
                  time: '2 hr ago',
                  distance: '2 Km away',
                  description:
                      'Experienced plumber needed for immediate repair of a leaking pipe in a residential area. Tools and materials provided on-site.',
                  actionButton: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Apply',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w300),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(40, 80, 200, 120),
                      side: BorderSide(
                          color: const Color.fromARGB(100, 80, 200, 120)),
                      minimumSize: Size(100, 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
                NewJobsCard(
                  title: ' repair',
                  urgency: 'Urgent',
                  time: '2 hr ago',
                  distance: '2 Km away',
                  description:
                      'Experienced plumber needed for immediate repair of a leaking pipe in a residential area. Tools and materials provided on-site.',
                  actionButton: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Apply',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w300),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(40, 80, 200, 120),
                      side: BorderSide(
                          color: const Color.fromARGB(100, 80, 200, 120)),
                      minimumSize: Size(100, 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Accepted Jobs Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Accepted',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton.icon(
                onPressed: () {},
                label: Text('See all'),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      fontSize: 14, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                LargeJobCard(                                                               
                  title: 'Electrical repair',
                  urgency: 'Urgent',
                  time: '2 hr ago',
                  distance: '2 Km away',
                  description:
                      'Experienced plumber needed for immediate repair of a leaking pipe in a residential area. Tools and materials provided on-site.',
                  actionButton: TextButton(
                    onPressed: () {},
                    child:
                        Text('Details', style: TextStyle(color: Colors.blue)),
                  ),
                ),
                LargeJobCard(
                  title: 'Electrical repair',
                  urgency: 'Urgent',
                  time: '2 hr ago',
                  distance: '2 Km away',
                  description:
                      'Experienced plumber needed for immediate repair of a leaking pipe in a residential area. Tools and materials provided on-site.',
                  actionButton: TextButton(
                    onPressed: () {},
                    child:
                        Text('Details', style: TextStyle(color: Colors.blue)),
                  ),
                )
              ])),
        ],
      ),
    );
  }
}

//drop down status
class DropdownStatus extends StatefulWidget {
  @override
  _DropdownStatusState createState() => _DropdownStatusState();
}

class _DropdownStatusState extends State<DropdownStatus> {
  String status = 'active';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
          isExpanded: false,
          value: status,
          // underline: SizedBox(),
          dropdownColor: Colors.blue[900],
          style: const TextStyle(color: Colors.white, fontSize: 12),
          items: const [
            DropdownMenuItem(
              value: 'active',
              child: Text('active', style: TextStyle(color: Colors.green)),
            ),
            DropdownMenuItem(
              value: 'deactivated',
              child: Text('deactivated', style: TextStyle(color: Colors.red)),
            ),
          ],
          onChanged: (value) {
            setState(() {
              status = value!;
            });
          },
        ),
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
                        'Become a service\n' ' seller',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          fontSize: 28,
                          wordSpacing: 2,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: SliderButton(
                        onTap: () {},
                        text: 'Find Gigs',
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
