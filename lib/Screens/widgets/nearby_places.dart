import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tripmate/Screens/tourist_details_page.dart';
import 'package:tripmate/controller/nearby_places_controller.dart';

class NearbyPlaces extends StatelessWidget {
  final NearbyPlacesController controller = Get.put(NearbyPlacesController());

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.nearbyPlaces.isEmpty) {
        return Center(child: Text('No nearby places found'));
      } else {
        return Flexible(
          child: ListView.builder(
            itemCount: controller.nearbyPlaces.length,
            itemBuilder: (context, index) {
              final place = controller.nearbyPlaces[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: screenSize.height * 0.15,
                  width: double.infinity,
                  child: Card(
                    elevation: 0.4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        final double parsedDistance = double.parse(place['distance']);
                        final String estimatedTime = _calculateEstimatedTime(parsedDistance);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TouristDetailsPage(
                              image: place['image'],
                              name: place['name'],
                              location: place['cityName'],
                              distance: parsedDistance,
                              estimatedTime: estimatedTime,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                place['image'],
                                height: screenSize.height * 0.13,
                                width: screenSize.width * 0.25,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    place['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(place['cityName']),
                                  Text('Distance: ${place['distance']} km'),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow.shade700,
                                        size: 14,
                                      ),
                                      const Text(
                                        "4.5",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    });
  }

  // Helper function to calculate estimated time
  String _calculateEstimatedTime(double distance) {
    const double speed = 60; // Assume 60 km/h average speed
    double timeInHours = distance / speed;

    int hours = timeInHours.floor();
    int minutes = ((timeInHours - hours) * 60).round();

    if (hours == 0) {
      return "${minutes}m";
    } else {
      return "${hours}h ${minutes}m";
    }
  }
}
