import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tripmate/Screens/tourist_details_page.dart';
import 'package:tripmate/controller/recommended_plcaes-controller.dart';

class RecommendedPlaces extends StatelessWidget {
  final RecommendedPlacesController controller = Get.put(RecommendedPlacesController());

  @override
  Widget build(BuildContext context) {
    controller.refreshPlaces();

    return Obx(() {
      if (controller.recommendedPlaces.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return SizedBox(
        height: 235,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final place = controller.recommendedPlaces[index];

            return SizedBox(
              width: 220,
              child: Card(
                elevation: 0.4,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    final double calculatedDistance = await calculateDistance(place.lat, place.long);
                    final String estimatedTime = _calculateEstimatedTime(calculatedDistance);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TouristDetailsPage(
                          image: place.image,
                          name: place.name,
                          location: place.city,
                          distance: calculatedDistance,
                          estimatedTime: estimatedTime,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            place.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            place.image,
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                            height: 150,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Ionicons.location,
                              color: Theme.of(context).primaryColor,
                              size: 16,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                place.city,
                                style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            FutureBuilder<double>(
                              future: calculateDistance(place.lat, place.long),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    '${snapshot.data!.toStringAsFixed(1)} km',
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  );
                                } else {
                                  return const Text('...');
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(right: 10),
          ),
          itemCount: controller.recommendedPlaces.length,
        ),
      );
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

  // Assuming you already have a calculateDistance function
  Future<double> calculateDistance(double lat, double long) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return Geolocator.distanceBetween(position.latitude, position.longitude, lat, long) / 1000;
  }
}
