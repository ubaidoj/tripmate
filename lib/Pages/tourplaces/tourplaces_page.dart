import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tripmate/Pages/tourplaces/Tourplaces_details.dart';
import 'package:tripmate/Pages/tourplaces/feature_controller.dart';

class Tourplacespage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FeatureController controller = Get.put(FeatureController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                'assets/icons/back_icon.svg',
                height: 24.0,
                width: 24.0,
                color: Colors.blue[900],
              ),
            ),
            Spacer(),
            Text(
              'Tour Places',
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                controller.searchPlaces(value);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.blue[900]),
                hintText: 'Search by city or place name...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue[900]!),
                ),
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<FeatureController>(
              builder: (controller) {
                if (controller.filteredTourPlaces.isEmpty) {
                  return Center(child: Text("No results found."));
                }
                return ListView.builder(
                  itemCount: controller.filteredTourPlaces.length,
                  itemBuilder: (context, index) {
                    final tourPlace = controller.filteredTourPlaces[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => TourplacesDetails(tour_places: tourPlace));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 5.0)
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        tourPlace['name'] ?? 'Unknown Place',
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        tourPlace['city'] ?? 'Unknown City',
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Image.asset(
                                    tourPlace['image'] ?? 'assets/images/placeholder.png',
                                    height: 100,
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
