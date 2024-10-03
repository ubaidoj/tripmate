import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tripmate/models/hotel_model.dart';

class HotelController extends GetxController {
  var hotels = <Hotel>[].obs;
  var filteredHotels = <Hotel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadHotels();
  }

  void loadHotels() async {
    try {
      // Load JSON file
      final String response = await rootBundle.loadString('assets/hotel_data.json');
      final List<dynamic> data = json.decode(response);
      // Parse the data into a list of Hotel objects
      hotels.value = data.map((json) => Hotel.fromJson(json)).toList();
      // Initialize filteredHotels with the full list of hotels
      filteredHotels.value = hotels;
      isLoading.value = false;
    } catch (e) {
      print("Error loading hotel data: $e");
      isLoading.value = false;
    }
  }

  void filterHotels(String query) {
    if (query.isEmpty) {
      // If the search query is empty, show all hotels
      filteredHotels.value = hotels;
    } else {
      // Filter hotels based on the search query
      filteredHotels.value = hotels.where((hotel) {
        final nameLower = hotel.name.toLowerCase();
        final locationLower = hotel.location.toLowerCase();
        final searchLower = query.toLowerCase();
        // Check if the search query matches either the name or location of the hotel
        return nameLower.contains(searchLower) || locationLower.contains(searchLower);
      }).toList();
    }
  }
}
 