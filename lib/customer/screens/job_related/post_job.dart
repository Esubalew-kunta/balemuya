import 'package:blaemuya/customer/screens/job_related/pick_location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class JobPostPage extends StatefulWidget {
  @override
  _JobPostPageState createState() => _JobPostPageState();
}

class _JobPostPageState extends State<JobPostPage> {
  String? selectedService;
  bool isUrgent = false;
  DateTime? selectedDate;
  String description = "";
  String? locationChoice;
  LatLng? pickedLocation;
  Position? currentLocation;

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
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enable location services")),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location permission denied")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location permissions are permanently denied")),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLocation = position;
      pickedLocation = LatLng(position.latitude, position.longitude);
    });
    print("current $currentLocation");
  }

  void _pickLocationOnMap() async {
    LatLng? selectedLatLng = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PickLocationScreen(),
      ),
    );

    if (selectedLatLng != null) {
      setState(() {
        pickedLocation = selectedLatLng;
      });
    }
    print("location $pickedLocation");
  }

  void _submitForm() {
    if (selectedService == null ||
        selectedDate == null ||
        pickedLocation == null ||
        description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    print("Service: $selectedService");
    print("Urgent: $isUrgent");
    print(
        "Date & Time: \${DateFormat('yyyy-MM-dd HH:mm').format(selectedDate!)}");
    print("Description: $description");
    print(
        "Location: \${pickedLocation!.latitude}, \${pickedLocation!.longitude}");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Job posted successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post a Job"),
        backgroundColor: Colors.indigo[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedService,
              hint: Text("Select service type"),
              items: services.map((service) {
                return DropdownMenuItem(value: service, child: Text(service));
              }).toList(),
              onChanged: (value) => setState(() => selectedService = value),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Urgent",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Switch(
                  value: isUrgent,
                  onChanged: (value) => setState(() => isUrgent = value),
                  activeColor: Colors.indigo,
                ),
              ],
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text(selectedDate == null
                  ? "Pick date & time"
                  : DateFormat('yyyy-MM-dd HH:mm').format(selectedDate!)),
              trailing: Icon(Icons.calendar_today, color: Colors.indigo),
              onTap: _pickDateTime,
              tileColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) => description = value,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Describe the problem",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            Text("Is this the place where the professional should come?",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text("Yes"),
                    value: "yes",
                    groupValue: locationChoice,
                    onChanged: (value) {
                      setState(() {
                        locationChoice = value;
                        _getCurrentLocation();
                      });
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
                        _pickLocationOnMap();
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text("Submit",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.indigo[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
