import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  GoogleMapController? mapController;
  var currentLocation = LatLng(0, 0).obs; // This is an Rx<LatLng> type
  var isLoading = true.obs;
  var distanceInfo = 'Enter locations to calculate the distance'.obs;
  LatLng? searchedLocation;

  final TextEditingController currentLocationController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  MapController(String? destinationLocation) {
    if (destinationLocation != null) {
      destinationController.text = destinationLocation;
      searchDestination(destinationLocation);
    }
    _getUserLocation();
  }

  // Get user's current location
  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLocation.value = LatLng(position.latitude, position.longitude);

      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        currentLocationController.text = placemarks[0].name ?? 'Current GPS Location';
      }
      isLoading.value = false;

      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: currentLocation.value, zoom: 14),
          ),
        );
      }
    } catch (e) {
      isLoading.value = false;
      distanceInfo.value = "Error: Unable to get location.";
    }
  }

  // Set the GoogleMapController
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (currentLocation.value != LatLng(0, 0)) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: currentLocation.value, zoom: 14),
        ),
      );
    }
  }

  // Search for a custom location (Current Location)
  Future<void> searchCurrentLocation(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      LatLng searchedLatLng = LatLng(locations[0].latitude, locations[0].longitude);

      currentLocation.value = searchedLatLng;
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: searchedLatLng, zoom: 14),
        ),
      );
    } catch (e) {
      distanceInfo.value = "Error: Unable to find current location.";
    }
  }

  // Search for the destination location
  Future<void> searchDestination(String address) async {
    try {
      if (address.isEmpty) {
        distanceInfo.value = "Error: Address is empty.";
        return;
      }

      List<Location> locations = await locationFromAddress(address.trim());
      if (locations.isNotEmpty) {
        LatLng destinationLatLng = LatLng(locations[0].latitude, locations[0].longitude);
        searchedLocation = destinationLatLng;

        mapController!.animateCamera(CameraUpdate.newLatLng(destinationLatLng));
        _calculateDistance();
      } else {
        distanceInfo.value = "Error: No location found for the entered address.";
      }
    } catch (e) {
      distanceInfo.value = "Error: Unable to find the destination.";
    }
  }

  // Calculate the distance between current and destination locations
  void _calculateDistance() {
    if (currentLocation != null && searchedLocation != null) {
      double distanceInMeters = Geolocator.distanceBetween(
        currentLocation.value.latitude,
        currentLocation.value.longitude,
        searchedLocation!.latitude,
        searchedLocation!.longitude,
      );
      double distanceInKm = distanceInMeters / 1000;
      double timeInMinutes = distanceInKm / 50 * 60; // assuming 50km/h speed

      distanceInfo.value =
          'Distance: ${distanceInKm.toStringAsFixed(2)} km\nEstimated time: ${timeInMinutes.toStringAsFixed(2)} minutes';
    }
  }
}
