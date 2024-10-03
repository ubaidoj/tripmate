import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/Screens/googlemaps_screen.dart';

class ForestDetails extends StatelessWidget {
  final dynamic forest;

  ForestDetails({required this.forest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      
        title: Text(forest['name']),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.blue[900]),
      ),
      body: SingleChildScrollView( // Allow scrolling in case of long content
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(forest['image'], width: MediaQuery.of(context).size.width * 0.9), // Make the image 90% of screen width
              SizedBox(height: 16),
              Text(
                'Location: ${forest['location']}', // Display mountain's location
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              if (forest.containsKey('history') && forest['history'] != null) // Check if history is available
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'History',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      forest['history'], // Display history
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ],
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Full Map Screen, passing the mountain's city as the destination
                  Get.to(() => FullScreenMap(destinationLocation: forest['location']));
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
