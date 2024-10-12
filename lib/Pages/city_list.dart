import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/Pages/city_details.dart';
import 'package:tripmate/controller/cirtylist_controller.dart';
import 'package:tripmate/controller/citydetails_controller.dart';

class CityListPage extends StatelessWidget {
  final CityListController controller = Get.put(CityListController());
  final CitydetailsController controller1 = Get.put(CitydetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cities in Pakistan"),
      ),
      body: Obx(() {
        if (controller.cities.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.cities.length,
          itemBuilder: (context, index) {
            var city = controller.cities[index];
            return FutureBuilder<double?>(
              future: controller.getDistanceFromUser(city['lat'], city['long']),
              builder: (context, snapshot) {
                var distance = snapshot.data;

                return GestureDetector(
                  onTap: () {
                    Get.to(CityDetailPage(city: city));
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          city['name'],
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Image.asset(city['image'], width: double.infinity, height: 150, fit: BoxFit.cover),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.red),
                                SizedBox(width: 4),
                                Text(
                                  city['location'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              distance != null
                                  ? "Distance: ${distance.toStringAsFixed(2)} km"
                                  : "Calculating distance...",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
