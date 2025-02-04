import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripmate/controller/map_controller.dart';
import 'package:tripmate/pages/fuelcalculator.dart';

class FullScreenMap extends StatelessWidget {
  final String? destinationLocation;

  FullScreenMap({this.destinationLocation});

  @override
  Widget build(BuildContext context) {
    // Initialize the MapController
    final MapController mapController = Get.put(MapController(destinationLocation));

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
          'Full Screen Map',
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
              // Extract only the numeric part of the distance (first line of distanceInfo without "km")
              String distance = mapController.distanceInfo.value.contains('\n')
                  ? mapController.distanceInfo.value.split('\n')[0].replaceAll(RegExp(r'[^\d.]'), '')
                  : '';

              if (distance.isNotEmpty) {
                Get.to(() => FuelCalculatorScreen(distance: distance));
              } else {
                // Show error if distance is not yet available
                Get.snackbar('Error', 'Distance is not available yet!');
              }
            },
          ),
        ],
      ),
      body: Obx(
        () => mapController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  GoogleMap(
                    onMapCreated: mapController.onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: mapController.currentLocation.value, 
                      zoom: 14.0,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    right: 10,
                    child: Column(
                      children: [
                        _buildSearchTextField(
                          controller: mapController.currentLocationController,
                          hintText: "Search current location",
                          onSubmitted: mapController.searchCurrentLocation,
                        ),
                        const SizedBox(height: 10),
                        _buildSearchTextField(
                          controller: mapController.destinationController,
                          hintText: "Search destination",
                          onSubmitted: mapController.searchDestination,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search, color: Colors.blue.shade900),
                            onPressed: () {
                              mapController.searchDestination(mapController.destinationController.text);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 10,
                    child: Container(
                      color: Colors.white.withOpacity(0.8),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Distance:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            mapController.distanceInfo.value.contains('\n')
                                ? mapController.distanceInfo.value.split('\n')[0]
                                : 'Calculating distance...',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Estimated Time:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            mapController.distanceInfo.value.contains('\n')
                                ? mapController.distanceInfo.value.split('\n')[1]
                                : 'Calculating time...',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  // Reusable method to build a search text field
  Widget _buildSearchTextField({
    required TextEditingController controller,
    required String hintText,
    required Function(String) onSubmitted,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blue.shade900),
        ),
        suffixIcon: suffixIcon,
      ),
      onSubmitted: onSubmitted,
    );
  }
}
