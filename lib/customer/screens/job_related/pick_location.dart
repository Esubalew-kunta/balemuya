import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationScreen extends StatefulWidget {
  @override
  _PickLocationScreenState createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  LatLng? selectedLocation;
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pick a Location")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(9.145, 40.4897), // Ethiopia's default center
          zoom: 6.0,
        ),
        onMapCreated: (controller) {
          mapController = controller;
        },
        onTap: (LatLng location) {
          setState(() {
            selectedLocation = location;
          });
        },
        markers: selectedLocation != null
            ? {
                Marker(
                  markerId: MarkerId("picked-location"),
                  position: selectedLocation!,
                ),
              }
            : {},
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          if (selectedLocation != null) {
            Navigator.pop(context, selectedLocation);
          }
        },
      ),
    );
  }
}
