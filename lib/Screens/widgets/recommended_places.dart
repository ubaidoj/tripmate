import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tripmate/Screens/tourist_details_page.dart';
import 'package:tripmate/controller/recommended_plcaes-controller.dart';

class RecommendedPlaces extends StatelessWidget {
  final RecommendedPlacesController controller = Get.put(RecommendedPlacesController());

  @override
  Widget build(BuildContext context) {

    controller.refreshPlaces();

    return Obx(() {
      // Check if the list is empty and show a loading spinner
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
                            Expanded(
                              child: Text(
                                place.location,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              Icons.star,
                              color: Colors.yellow.shade700,
                              size: 14,
                            ),
                            Text(
                              place.rating.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
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
                                place.location,
                                style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        )
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
}
