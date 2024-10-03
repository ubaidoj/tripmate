import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/Screens/googlemaps_screen.dart';

class MountainDetailPage extends StatelessWidget {
  final dynamic mountain;

  MountainDetailPage({required this.mountain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      
        title: Text(mountain['name']),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.blue[900]),
      ),
      body: SingleChildScrollView( // Allow scrolling in case of long content
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(mountain['image'], width: MediaQuery.of(context).size.width * 0.9), // Make the image 90% of screen width
              SizedBox(height: 16),
              Text(
                'Location: ${mountain['location']}', // Display mountain's location
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              if (mountain.containsKey('history') && mountain['history'] != null) // Check if history is available
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'History',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      mountain['history'], // Display history
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ],
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Full Map Screen, passing the mountain's city as the destination
                  Get.to(() => FullScreenMap(destinationLocation: mountain['location']));
                },
                child: Text('View Location on Map'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
