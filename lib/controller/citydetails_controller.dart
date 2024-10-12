import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class CitydetailsController extends GetxController {
  var cities = [].obs;  // Observable list for city data
  Position? currentPosition;

  // Create a reactive variable to hold the distance info
  var distanceInfo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCitiesFromJson();  // Load the cities when the controller is initialized
    _determinePosition();  // Get the user's current location
  }

  // Load city data from the JSON file
  Future<void> loadCitiesFromJson() async {
    final String response = await rootBundle.loadString('assets/cities.json');
    final data = json.decode(response);
    cities.value = data;
  }

  // Get the user's current position
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    currentPosition = await Geolocator.getCurrentPosition();
  }

  // Calculate distance from the user's current location to the city's location
  Future<void> getDistanceFromUser(double? cityLat, double? cityLon) async {
    if (currentPosition == null || cityLat == null || cityLon == null) {
      distanceInfo.value = 'Unable to calculate distance';
      return;
    }

    double distance = Geolocator.distanceBetween(
      currentPosition!.latitude,
      currentPosition!.longitude,
      cityLat,
      cityLon,
    );

    // Set the distance information to the reactive variable
    distanceInfo.value = 'Distance: ${distance.toStringAsFixed(2)} km';
  }
}
