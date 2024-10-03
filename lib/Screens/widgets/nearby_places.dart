import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/Screens/tourist_details_page.dart';
import 'package:tripmate/controller/nearby_places_controller.dart';

class NearbyPlaces extends StatelessWidget {
  final NearbyPlacesController controller = Get.put(NearbyPlacesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Column(
          children: List.generate(controller.nearbyPlaces.length, (index) {
            final place = controller.nearbyPlaces[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                height: 135,
                width: double.maxFinite,
                child: Card(
                  elevation: 0.4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TouristDetailsPage(
                            image: place['image'],
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
                            child: Image.network(
                              place['image'],
                              height: double.maxFinite,
                              width: 130,
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
                                Text(place['location']),
                                const SizedBox(height: 10),
                                Text(place['category']),
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      }
    });
  }
}
