import 'package:blaemuya/widgets/job/customer_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  // Google Maps controller
  late GoogleMapController _mapController;

  // Initial map position (latitude, longitude)
  final LatLng _initialPosition = LatLng(11.5938008, 37.3951661); 

  // Bottom sheet controller
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              setState(() {
                _mapController = controller;
              });
            },
            markers: {
              Marker(
                markerId: MarkerId('initial_position'),
                position: _initialPosition,
                infoWindow: InfoWindow(title: 'Your Location'),
              ),
            },
          ),

          // Bottom Sheet
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.2, // Initial size of the bottom sheet
            minChildSize: 0.1, // Minimum size of the bottom sheet
            maxChildSize: 0.3, // Maximum size of the bottom sheet
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
                        CustomerInfoCard(
                name: "Kebede Abebe",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9SRRmhH4X5N2e4QalcoxVbzYsD44C-sQv-w&s",
                rating: 4.5,
                address: "Addis Ababa",
                peopleHired: 15,
                onImageTap: () {
                  // Handle image click action
                   
                 
                },),
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