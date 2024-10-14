import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CitydetailsController extends GetxController {
  var distanceInfo = ''.obs;     // Stores only the distance information
  var estimatedTime = ''.obs;    // Stores only the estimated time information

  Position? currentPosition;

  // Initialize with getting user's current position
  @override
  void onInit() {
    super.onInit();
    _determinePosition();
  }

  // Get current location and distance for detail view
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check location permissions
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

    // Get the current position of the user
    currentPosition = await Geolocator.getCurrentPosition();
  }

  // Calculate the distance to the city and estimated time
  Future<void> getDistanceFromUser(double? cityLat, double? cityLon) async {
    if (currentPosition == null || cityLat == null || cityLon == null) {
      distanceInfo.value = "Distance info unavailable";
      estimatedTime.value = "Time info unavailable";
      return;
    }

    // Calculate distance in meters between user and the city
    final distanceInMeters = Geolocator.distanceBetween(
      currentPosition!.latitude,
      currentPosition!.longitude,
      cityLat,
      cityLon,
    );

    // Convert the distance to kilometers
    final distanceInKm = distanceInMeters / 1000;

    // Calculate the estimated time in hours, assuming an average speed of 80 km/h
    final estimatedTimeInHours = distanceInKm / 80;

    // Update the observable values separately
    distanceInfo.value = "${distanceInKm.toStringAsFixed(2)} km";
    estimatedTime.value = "${estimatedTimeInHours.toStringAsFixed(2)} hours";
  }
}
