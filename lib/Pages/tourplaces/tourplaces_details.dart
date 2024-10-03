import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/Screens/googlemaps_screen.dart';

class TourplacesDetails extends StatelessWidget {
  final dynamic tour_places;

  TourplacesDetails({required this.tour_places});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(tour_places['name'] ?? 'Unknown Place'), // Handle null case
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.blue[900]),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                tour_places['image'] ?? 'assets/images/placeholder.png', // Provide a placeholder image for null case
                width: MediaQuery.of(context).size.width * 0.9,
              ),
              SizedBox(height: 16),
              Text(
                'Location: ${tour_places['location'] ?? 'Unknown Location'}', // Handle null case for location
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              if (tour_places.containsKey('history') && tour_places['history'] != null) // Check if history exists and is not null
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'History',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      tour_places['history'] ?? 'No history available', // Provide a fallback for missing history
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ],
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Full Map Screen, passing the location if available
                  Get.to(() => FullScreenMap(destinationLocation: tour_places['location'] ?? 'Unknown Location'));
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
