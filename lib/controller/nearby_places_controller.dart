import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' as rootBundle;

class NearbyPlacesController extends GetxController {
  var nearbyPlaces = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNearbyPlaces();
  }

  // Function to calculate the distance between two coordinates (Haversine formula)
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double p = 0.017453292519943295; // Conversion factor to radians
    final double a = 0.5 - cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  Future<Position> _getUserCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, return an error.
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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Permissions are granted, retrieve the current location.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> fetchNearbyPlaces() async {
    isLoading(true);

    try {
      // Fetch user's current location
      Position position = await _getUserCurrentLocation();
      final userLat = position.latitude;
      final userLong = position.longitude;

      // Load the JSON file from assets
      final jsonString =
          await rootBundle.rootBundle.loadString('assets/cities.json');
      final data = json.decode(jsonString) as List;

      List<Map<String, dynamic>> filteredPlaces = [];

      // Filter places that are nearby (within a certain distance)
      for (var city in data) {
        final cityLat = city['lat'];
        final cityLong = city['long'];
        double distance = calculateDistance(userLat, userLong, cityLat, cityLong);

        if (distance <= 100) { // Places within 100 km
          filteredPlaces.add({
            ...city,
            'distance': distance.toStringAsFixed(2), // Add distance to the map
          });
        }
      }

      // Sort places from low distance to high distance
      filteredPlaces.sort((a, b) => a['distance'].compareTo(b['distance']));

      nearbyPlaces.value = filteredPlaces;

      if (nearbyPlaces.isEmpty) {
        print("No nearby places found");
      }

    } catch (e) {
      print("Error fetching nearby places: $e");
    }

    isLoading(false);
  }
}
