import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import 'googlemaps_screen.dart';
import 'widgets/distance.dart';
import 'package:tripmate/controller/saved_location_controller.dart';

class TouristDetailsPage extends StatelessWidget {
  const TouristDetailsPage({
    Key? key,
    required this.image,
    required this.name,
    required this.location,
    required this.distance,
    required this.estimatedTime,
  }) : super(key: key);

  final String image;
  final String name;
  final String location;
  final double distance;
  final String estimatedTime;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final SavedLocationController savedLocationController = Get.find<SavedLocationController>();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            // Image section with heart icon for saving location
            SizedBox(
              height: size.height * 0.38,
              width: double.maxFinite,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            iconSize: 20,
                            icon: const Icon(Ionicons.chevron_back),
                          ),
                          Obx(() {
                            final isSaved = savedLocationController.isLocationSaved(name);
                            return IconButton(
                              iconSize: 20,
                              onPressed: () {
                                if (isSaved) {
                                  savedLocationController.savedLocations.removeWhere(
                                    (item) => item['name'] == name,
                                  );
                                } else {
                                  savedLocationController.addLocation(name, location, image);
                                }
                              },
                              icon: Icon(
                                isSaved ? Ionicons.heart : Ionicons.heart_outline,
                                color: isSaved ? Colors.red : null,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Name and location
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      location,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "4.6",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Icon(
                      Ionicons.star,
                      color: Colors.yellow[800],
                      size: 15,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Distance and estimated time info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${distance.toStringAsFixed(2)} km",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Distance from you",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      estimatedTime,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Estimated time to reach",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Map preview container
            Container(
              height: 180,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                image: const DecorationImage(
                  image: AssetImage('assets/map.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Additional distance widget
            const Distance(),
            const SizedBox(height: 20),
            // Join tour button
            ElevatedButton(
              onPressed: () {
                // Navigate to full map screen with destination location
                Get.to(() => FullScreenMap(destinationLocation: location));
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 8.0,
                ),
              ),
              child: const Text("Join this tour"),
            ),
          ],
        ),
      ),
    );
  }
}
