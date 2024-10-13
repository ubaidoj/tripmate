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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> fetchNearbyPlaces() async {
    isLoading(true);

    try {
      Position position = await _getUserCurrentLocation();
      final userLat = position.latitude;
      final userLong = position.longitude;

      // Load the JSON data
      final jsonString =
          await rootBundle.rootBundle.loadString('assets/cities.json');
      final data = json.decode(jsonString) as List;

      List<Map<String, dynamic>> filteredPlaces = [];

      // Process the cities and their places
      for (var city in data) {
        final cityLat = city['lat'];
        final cityLong = city['long'];
        double distance = calculateDistance(userLat, userLong, cityLat, cityLong);

        // Loop through all categories like tour_places, mountains, forests, etc.
        for (var category in ['tour_places', 'mountains', 'forests', 'beaches']) {
          if (city[category] != null) { // Check if category exists
            for (var place in city[category]) {
              double placeDistance = calculateDistance(
                  userLat, userLong, place['lat'], place['long']);
              if (placeDistance <= 100) { // Places within 150 km
                filteredPlaces.add({
                  'name': place['name'],
                  'cityName': city['name'],
                  'distance': placeDistance.toStringAsFixed(2),
                  'image': place['image']
                });
              }
            }
          }
        }
      }

      // Sort places by distance
      filteredPlaces.sort((a, b) => a['distance'].compareTo(b['distance']));
      nearbyPlaces.value = filteredPlaces;

    } catch (e) {
      print("Error fetching nearby places: $e");
    }

    isLoading(false);
  }
}
