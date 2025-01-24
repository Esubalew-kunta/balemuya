import 'package:blaemuya/widgets/small_button_bright.dart';
import 'package:blaemuya/widgets/small_button_dark.dart';
import 'package:flutter/material.dart';





class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/maintainance.jpg'), 
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi Abebe', style: TextStyle(color: Colors.white)),
            Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 12),
                SizedBox(width: 4),
                Text('active', style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: const [
          
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Location Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.blue[900]),
                  SizedBox(width: 8),
                  Text('Bahir Dar, poly'),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.refresh, size: 16),
                label: Text('Update location'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  textStyle: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          // Banner Section
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage('assets/images/maintainance.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children:[

                SmallButtonDark(
                    onTap: () {
                     
                    },
                    text: 'Find Gigs', isSelected: true,
                    
                  ),
              ] 
            ),
          ),
          SizedBox(height: 16),
          
          // New Jobs Section
          Text('New jobs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          JobCard(
            title: 'Plumbing repair',
            urgency: 'Urgent',
            time: '2 hr ago',
            distance: '2 Km away',
            description: 'Experienced plumber needed for immediate repair of a leaking pipe in a residential area. Tools and materials provided on-site.',
            actionButton: ElevatedButton(
              onPressed: () {},
              child: Text('Apply'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ),
          SizedBox(height: 16),

          // Accepted Jobs Section
          Text('Accepted', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          JobCard(
            title: 'Plumbing repair',
            urgency: 'Urgent',
            time: '2 hr ago',
            distance: '2 Km away',
            description: 'Experienced plumber needed for immediate repair of a leaking pipe in a residential area. Tools and materials provided on-site.',
            actionButton: TextButton(
              onPressed: () {},
              child: Text('Details', style: TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String title;
  final String urgency;
  final String time;
  final String distance;
  final String description;
  final Widget actionButton;

  JobCard({
    required this.title,
    required this.urgency,
    required this.time,
    required this.distance,
    required this.description,
    required this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(urgency, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(time, style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(width: 16),
                Text(distance, style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            SizedBox(height: 8),
            Text(description, style: TextStyle(fontSize: 14)),
            SizedBox(height: 8),
            Align(alignment: Alignment.centerRight, child: actionButton),
          ],
        ),
      ),
    );
  }
}
