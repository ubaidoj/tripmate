import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripmate/Screens/googlemaps_screen.dart';
import 'package:tripmate/controller/cirtylist_controller.dart';
import 'package:tripmate/controller/citydetails_controller.dart';

class CityDetailPage extends StatelessWidget {
  final Map city;
  final CitydetailsController citydetailsController = Get.find(); // Use Get.find() to get the existing controller

  CityDetailPage({required this.city});

  @override
  Widget build(BuildContext context) {
    // Call getDistanceFromUser() to calculate distance as soon as the page is built
    citydetailsController.getDistanceFromUser(city['lat'], city['long']);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/back_icon.svg'), // SVG Back Icon
          onPressed: () {
            Get.back(); // Go back to the previous page
          },
        ),
        title: Text(
          city['name'],
          style: TextStyle(
            color: Colors.blue.shade900, // Dark blue color
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.calculate, color: Colors.blue.shade900),
            onPressed: () {
              // Navigate to any calculator or related page if required
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // City Image
            Image.asset(
              city['image'],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            // City Name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                city['name'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // City Location and View on Map button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue.shade900),
                      SizedBox(width: 4),
                      Text(
                        city['location'],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Full Screen Map
                      Get.to(() => FullScreenMap(destinationLocation: city['location']));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text("View on Map"),
                  ),
                ],
              ),
            ),
            // City Distance and Estimated Time
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      title: "",
                      value: citydetailsController.distanceInfo.value,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable method to build info rows (Distance, Time, etc.)
  Widget _buildInfoRow({required String title, required String value}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
