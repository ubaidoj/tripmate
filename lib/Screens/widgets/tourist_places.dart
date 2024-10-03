import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tripmate/Pages/city_list.dart';
import 'package:tripmate/Pages/tourplaces/beaches_page.dart';
import 'package:tripmate/Pages/tourplaces/deserts_page.dart';
import 'package:tripmate/Pages/tourplaces/forest_page.dart';
import 'package:tripmate/Pages/tourplaces/mountain_page.dart';
import 'package:tripmate/Pages/tourplaces/tourplaces_page.dart';
import 'package:tripmate/controller/touirst_controller.dart';
import 'package:tripmate/models/tourist_places_model.dart';

class TouristPlaces extends StatelessWidget {
  final TouristPlacesController touristPlacesController = Get.put(TouristPlacesController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  switch (touristPlaces[index].name) {
                    case 'Beach':
                      Get.to(() => BeachesPage());
                      break;
                    case 'Forest':
                      Get.to(() => ForestPage());
                      break;
                    case 'City':
                      Get.to(() => CityListPage());
                      break;
                    case 'Famous Places':
                      Get.to(() => Tourplacespage());
                      break;
                    case 'Mountain':
                      Get.to(() => MountainsPage());
                      break;
                      case 'Desert':
                      Get.to(() => DesertsPage());
                      break;
                    default:
                      break;
                  }
                },
                child: Chip(
                  label: Text(touristPlaces[index].name),
                  avatar: CircleAvatar(
                    backgroundImage: AssetImage(touristPlaces[index].image),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.only(right: 10)),
            itemCount: touristPlaces.length,
          ),
        ),
        Obx(() {
          if (touristPlacesController.isLoading.value) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            );
          }

          if (touristPlacesController.showCityList.value) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: touristPlacesController.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Cities...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: touristPlacesController.filterCities,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: touristPlacesController.filteredCities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(touristPlacesController.filteredCities[index]),
                    );
                  },
                ),
              ],
            );
          }

          return Container();
        }),
      ],
    );
  }
}