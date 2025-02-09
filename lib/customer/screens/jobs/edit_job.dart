import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:blaemuya/widgets/large_button.dart';
import 'package:blaemuya/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'pick_location.dart'; // Ensure this import is correct

class EditPostedJob extends StatefulWidget {
   final Map<String, dynamic> job; // Accept job data as a Map

  EditPostedJob({required this.job});
  @override
  _EditPostedJobState createState() => _EditPostedJobState();
}

class _EditPostedJobState extends State<EditPostedJob> {
  String? selectedService;
  bool isUrgent = false;
  DateTime? selectedDate;
  String description = "";
  String? locationChoice;
  LatLng? pickedLocation;
  Position? currentLocation;
  bool isLoading = false;
  bool isPickingLocation = false; // New variable to track if picking location

  final List<String> services = [
    "Plumbing",
    "Electrician",
    "Painting",
    "Cleaning"
  ];

  Future<void> _pickDateTime() async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoading = true;
      locationChoice = "yes";
      pickedLocation = null;
    });

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      setState(() => isLoading = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location permission denied")),
        );
        setState(() => isLoading = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location permissions are permanently denied")),
      );
      setState(() => isLoading = false);
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      setState(() {
        currentLocation = position;
        pickedLocation = LatLng(position.latitude, position.longitude);
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to get current location")),
      );
      setState(() => isLoading = false);
    }
  }

  void _pickLocationOnMap() async {
    setState(() {
      locationChoice = "no";
      isPickingLocation = true; // Set picking location to true
    });

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    LatLng userCurrentLocation = LatLng(position.latitude, position.longitude);

    LatLng? selectedLatLng = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PickLocationScreen(initialLocation: userCurrentLocation),
      ),
    );

    setState(() {
      isPickingLocation = false; // Set picking location to false
    });

    if (selectedLatLng != null) {
      setState(() {
        pickedLocation = selectedLatLng;
      });
    }
  }

  void _submitForm() {
    if (selectedService == null ||
        selectedDate == null ||
        pickedLocation == null ||
        description.isEmpty) {
      showCustomSnackBar(
        context,
        title: 'Info',
        message: "Please fill all fields!",
        type: AnimatedSnackBarType.info,
      );
      return;
    }

    print("Service: $selectedService");
    print("Urgent: $isUrgent");
    print(
        "Date & Time: ${DateFormat('yyyy-MM-dd HH:mm').format(selectedDate!)}");
    print("Description: $description");
    print(
        "Location: ${pickedLocation!.latitude}, ${pickedLocation!.longitude}");

    showCustomSnackBar(
      context,
      title: 'Success',
      message: "Job posted successfully",
      type: AnimatedSnackBarType.success,
    );
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText("Post Job"),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Center(
        child: Card(
          color: const Color.fromARGB(255, 255, 255, 255),
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildServiceDropdown(),
                  SizedBox(height: 16),
                  _buildUrgentSwitch(),
                  SizedBox(height: 16),
                  _buildDateTimePicker(),
                  SizedBox(height: 16),
                  _buildDescriptionField(),
                  SizedBox(height: 16),
                  _buildLocationSelection(),
                  SizedBox(height: 16),
                  LargeButton(
                    onTap: _submitForm,
                    text: "Post",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedService,
      hint: Text("Select service type"),
      items: services.map((service) {
        return DropdownMenuItem(value: service, child: Text(service));
      }).toList(),
      onChanged: (value) => setState(() => selectedService = value),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildUrgentSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Urgent",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Switch(
          value: isUrgent,
          onChanged: (value) => setState(() => isUrgent = value),
          activeColor: primaryColor,
        ),
      ],
    );
  }

  Widget _buildDateTimePicker() {
    return ListTile(
      title: Text(selectedDate == null
          ? "Pick date & time"
          : DateFormat('yyyy-MM-dd HH:mm').format(selectedDate!)),
      trailing: Icon(Icons.calendar_today, color: Colors.indigo),
      onTap: _pickDateTime,
      tileColor: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      onChanged: (value) => description = value,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: "Describe the problem",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildLocationSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Is this the place where the professional should come?",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: Text("Yes"),
                value: "yes",
                groupValue: locationChoice,
                onChanged: (value) async {
                  setState(() {
                    locationChoice = value;
                    pickedLocation = null;
                  });
                  await _getCurrentLocation();
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text("No"),
                value: "no",
                groupValue: locationChoice,
                onChanged: (value) {
                  setState(() {
                    locationChoice = value;
                  });
                  _pickLocationOnMap();
                },
              ),
            ),
          ],
        ),
        if (locationChoice == "yes" && isLoading)
          Center(child: CircularProgressIndicator()),
        if (locationChoice == "yes" && currentLocation != null)
          Center(
              child: Text("Location registered.",
                  style: TextStyle(color: Colors.green))),
        if (locationChoice == "no" && isPickingLocation)
          Center(child: CircularProgressIndicator()),
        if (locationChoice == "no" && pickedLocation != null)
          Center(
              child: Text("Location picked.",
                  style: TextStyle(color: Colors.green))),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitForm,
        child: Text("Submit",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          backgroundColor: Colors.indigo[900],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
