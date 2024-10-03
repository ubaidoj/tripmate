import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/Screens/googlemaps_screen.dart';

class BeachesDetails extends StatelessWidget {
  final dynamic beaches;

  BeachesDetails({required this.beaches});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(beaches['name'] ?? 'Unknown Beach'),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.blue[900]),
      ),
      body: SingleChildScrollView( // Allow scrolling in case of long content
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              beaches['image'] != null
                  ? Image.asset(
                      beaches['image'],
                      width: MediaQuery.of(context).size.width * 0.9,
                    ) // Make the image 90% of screen width
                  : Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: Center(child: Text('No Image Available')),
                    ),
              SizedBox(height: 16),
              Text(
                'Location: ${beaches['location'] ?? 'Unknown Location'}', // Display beach's location
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              if (beaches.containsKey('history') && beaches['history'] != null) // Check if history is available
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'History',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      beaches['history'], // Display history
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ],
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Full Map Screen, passing the beach's location
                  Get.to(() => FullScreenMap(destinationLocation: beaches['location']));
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
