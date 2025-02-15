import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/features/auth/controller/auth_controller.dart';
import 'package:blaemuya/features/auth/controller/user_controller.dart';
import 'package:blaemuya/professional/screens/bottom_nav.dart';
import 'package:blaemuya/professional/screens/jobs/inprogress_jobs_detail.dart';
import 'package:blaemuya/professional/screens/jobs/job_details.dart';
import 'package:blaemuya/professional/screens/jobs/new_jobs.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/large_job_card.dart';
import 'package:blaemuya/widgets/new_jobs_card.dart';
import 'package:blaemuya/widgets/slider_button.dart';
import 'package:blaemuya/widgets/small_button_bright.dart';
import 'package:blaemuya/widgets/small_button_dark.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class ProfessionalHome extends ConsumerStatefulWidget {
  const ProfessionalHome({super.key});

  @override
  ConsumerState<ProfessionalHome> createState() => _ProfessionalHomeState();
}

class _ProfessionalHomeState extends ConsumerState<ProfessionalHome> {
  String _locationMessage = "Bahir Dar ,Amhara";
  String _country = "ethiopia";
  String _locality = "am";
  String _AdministrativeArea = "a";
  double _latitude = 0.0;
  double _longitude = 0.0;

  // Function to fetch the current location and display it
  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          // ignore: deprecated_member_use
          desiredAccuracy: LocationAccuracy.high);

      // Fetch area name from coordinates using reverse geocoding
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        _AdministrativeArea = place.administrativeArea ?? "Unknown area";
        _locality = place.locality ?? "Unknown locality";

        _locationMessage = "$_locality, $_AdministrativeArea";
      });
      final locationData = {
        "country": _country,
        "city": _locality,
        "region": _AdministrativeArea,
        "latitude": _latitude,
        "longitude": _longitude,
      };

      // Call the controller (Now it returns a response)
      final response = await ref
          .read(userControllerProvider)
          .updateCurrentLocation(locationData);
      if (response.isNotEmpty) {
        if (response["success"] == true) {
          // Show success message
          AnimatedSnackBar.material(
            response["message"],
            type: AnimatedSnackBarType.success,
          ).show(context);
        }
      } else {
        // Show error message
        AnimatedSnackBar.material(
          response["message"],
          type: AnimatedSnackBarType.error,
        ).show(context);
      }
      print(
          'Locxx: $_latitude, $_longitude, $_country, $_locality, $_AdministrativeArea');
    } catch (e) {
      print("Error getting location: $e");
      setState(() {
        _locationMessage = "Unable to fetch location.";
      });
    }
  }

  void _updateLocation() async {
    {
      try {
        final locationData = {
          "country": _country,
          "city": _locality,
          "region": _AdministrativeArea,
          "latitude": _latitude,
          "longitude": _longitude,
        };

        // Call the controller (Now it returns a response)
        final response = await ref
            .read(userControllerProvider)
            .updateCurrentLocation(locationData);

        // Remove loading indicator
        if (mounted) Navigator.pop(context);

        if (response["success"] == true) {
          // Show success message
          AnimatedSnackBar.material(
            response["message"],
            type: AnimatedSnackBarType.success,
          ).show(context);

          // Redirect to login after 2 seconds
        } else {
          // Show error message
          AnimatedSnackBar.material(
            response["message"],
            type: AnimatedSnackBarType.error,
          ).show(context);
        }
      } catch (e) {
        // Remove loading indicator
        if (mounted) Navigator.pop(context);

        // Show error snackbar
        AnimatedSnackBar.material(
          "An unexpected error occurred. Please try again.",
          type: AnimatedSnackBarType.error,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                  backgroundImage: AssetImage('assets/images/avator.png'),
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
                  child:
                      Icon(Icons.error, color: Color.fromARGB(255, 2, 255, 36)),
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
                  Text(" $_locationMessage "),
                ],
              ),
              TextButton.icon(
                onPressed: () async {
                  await _getLocation();
                  // _updateLocation();
                },
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewJobs()),
                  );
                },
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobDetails(),
                        ),
                      );
                    },
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobDetails(),
                        ),
                      );
                    },
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
              Text('In Progress',
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InprogressJobsDetail()),
                      );
                    },
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InprogressJobsDetail()),
                      );
                    },
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
        autoPlayInterval: Duration(seconds: 4), // Set the interval time
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewJobs(),
                            ),
                          );
                        },
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
