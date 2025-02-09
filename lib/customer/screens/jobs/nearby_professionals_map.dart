import 'package:blaemuya/customer/screens/jobs/applied_professional_profile.dart';
import 'package:blaemuya/customer/screens/jobs/jobs_card/professional_profiles_list_for_customer_card.dart';
import 'package:blaemuya/customer/screens/jobs/nearby_professional_profile_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:blaemuya/widgets/job/customer_profile_card.dart';

class NearbyProfessionalsMap extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
  final String title; 
  const NearbyProfessionalsMap({Key? key, required this.title}) : super(key: key);
}

class _MapsState extends State<NearbyProfessionalsMap> {
  
   List<String> _professionalTypes = [
    'Plumber',
    'Electrician',
    'Carpenter',
    'Painter',
    'Mechanic',
    'Mason',
  ];

  String? _selectedProfessionalType;

  // Google NearbyProfessionalsMap controller
  late GoogleMapController _mapController;

  // Initial map position (latitude, longitude)
  final LatLng _initialPosition = LatLng(11.5938008, 37.3951661); 

  // Bottom sheet controller
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  // Navigate to a new page
  void _navigateToDetails() {
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NearbyProfessionalProfileDetail(), 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
           
          // Google Map at the top
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 15.0,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            // You can add markers, actions, etc. here
          ),
          Positioned(
  top: 40,
  left: 20,
  right: 20,
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.8),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: DropdownButtonFormField<String>(
      value: _selectedProfessionalType,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      hint: Text('Select Professional Type'),
      isExpanded: true,
      items: _professionalTypes.map((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedProfessionalType = newValue;
        });
      },
      dropdownColor: Colors.white,
      menuMaxHeight: 200, 
      itemHeight: 50, 
   
    ),
  ),
),
          // Draggable bottom sheet
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.2, 
            minChildSize: 0.1,
            maxChildSize: 0.6, 
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.all(16),
                  children: [
                    Center(
                      child: Column(
                        children: [
                           Text(widget.title),
                          GestureDetector(
                            onTap: _navigateToDetails, 
                            child: ProfessionalProfilesListForCustomer(
                              name: "Esubalew Kunta",
                              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9SRRmhH4X5N2e4QalcoxVbzYsD44C-sQv-w&s",
                              rating: 4.5,
                              distance: "4.5 km away",
                              categories: "plumber, Electrician",
                              onImageTap: () {
                                // Handle image click action
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// A placeholder for the new page that will be navigated to
class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Page"),
      ),
      body: Center(
        child: Text("This is a new page!"),
      ),
    );
  }
}
