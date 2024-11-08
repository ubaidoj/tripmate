import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/Screens/tourist_details_page.dart';
import 'package:tripmate/controller/saved_location_controller.dart';

class SavedLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SavedLocationController savedLocationController = Get.put(SavedLocationController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Locations"),
      ),
      body: Obx(() {
        return savedLocationController.savedLocations.isEmpty
            ? Center(child: Text("No saved locations"))
            : ListView.builder(
                itemCount: savedLocationController.savedLocations.length,
                itemBuilder: (context, index) {
                  final location = savedLocationController.savedLocations[index];
                  
                  return GestureDetector(
                    onTap: () {
                      // Navigate to TouristDetailsPage with location data
                      Get.to(() => TouristDetailsPage(
                            name: location['name'],
                            location: location['location'],
                            image: location['image'],
                            distance: 0.0, // Set actual distance if available
                            estimatedTime: "15 mins", // Set actual time if available
                          ));
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Place name at the top
                            Text(
                              location['name'],
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            // Place image centered in the list item
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  location['image'],
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Bottom section with place location and live location
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Live location icon from Google Maps
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: Colors.blue),
                                    Text(
                                      "Live location", // Placeholder for live location
                                      style: TextStyle(color: Colors.blue[700]),
                                    ),
                                  ],
                                ),
                                // Place location in bottom right
                                Text(
                                  location['location'],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
      }),
    );
  }
}
