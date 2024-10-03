import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/Pages/city_details.dart';
import 'package:tripmate/controller/cirtylist_controller.dart';

class CityListPage extends StatelessWidget {
  final CityListController controller = Get.put(CityListController());

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
            return ListTile(
              leading: Image.asset(city['image'], width: 50, height: 50, fit: BoxFit.cover),
              title: Text(city['name']),
              subtitle: Text(city['location']),
              onTap: () {
                Get.to(CityDetailPage(city: city));
              },
            );
          },
        );
      }),
    );
  }
}
