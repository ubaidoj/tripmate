import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tripmate/Pages/fuelcalculator.dart';
import 'package:tripmate/Screens/googlemaps_screen.dart';
import 'package:tripmate/controller/citydetails_controller.dart';

class CityDetailPage extends StatelessWidget {
  final Map city;
  final CitydetailsController citydetailsController = Get.find();

  CityDetailPage({required this.city});

  @override
  Widget build(BuildContext context) {
    // Fetch the distance and estimated time
    citydetailsController.getDistanceFromUser(city['lat'], city['long']);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/back_icon.svg'),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          city['name'],
          style: TextStyle(
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.calculate, color: Colors.blue.shade900),
            onPressed: () {
              // Pass the integer part of the distance to the FuelCalculatorScreen
              double distance = double.tryParse(citydetailsController.distanceInfo.value) ?? 0.1;
              Get.to(FuelCalculatorScreen(distance: distance.toStringAsFixed(0)));
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
                children: [
                  Icon(Icons.location_on, color: Colors.blue.shade900),
                  SizedBox(width: 4),
                  Text(
                    city['location'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // City Distance and Estimated Time (displayed separately)
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      title: "Distance:",
                      value: "${citydetailsController.distanceInfo.value} ",  // Show distance
                    ),
                    _buildInfoRow(
                      title: "Estimated Time:",
                      value: "${citydetailsController.estimatedTime.value} ",  // Show estimated time
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            // View on Map button (80% width)
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => FullScreenMap(destinationLocation: city['location']));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text("View on Map", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            // Tour Places, Mountains, etc.
            _buildTourDetails("Tourist Places", city['tour_places']),
            _buildTourDetails("Mountains", city['mountains']),
            _buildTourDetails("Deserts", city['deserts']),
            _buildTourDetails("Forests", city['forests']),
            _buildTourDetails("Beaches", city['beaches']),
          ],
        ),
      ),
    );
  }

  // Reusable method to build info rows (Distance, Time)
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

  // Method to build details for Tour places, Mountains, etc.
  Widget _buildTourDetails(String title, List<dynamic> items) {
    if (items.isEmpty) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: items.map((item) {
              return Card(
                child: ListTile(
                  leading: Image.asset(item['image'], width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(item['name']),
                  subtitle: Text(item['history'] ?? ""),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
