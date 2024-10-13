import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tripmate/controller/recommended_plcaes-controller.dart';
import 'package:tripmate/screens/tourist_details_page.dart';

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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TouristDetailsPage(
                          image: place.image,
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
                            )
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

  Future<double> calculateDistance(double lat, double long) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return Geolocator.distanceBetween(position.latitude, position.longitude, lat, long) / 1000;
  }
}
