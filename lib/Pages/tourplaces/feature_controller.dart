import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FeatureController extends GetxController {
  List<dynamic> mountains = [];
  List<dynamic> beaches = [];
  List<dynamic> deserts = [];
  List<dynamic> forests = [];
  List<dynamic> tourPlaces = [];

  // Filtered lists for search results
  List<dynamic> filteredMountains = [];
  List<dynamic> filteredBeaches = [];
  List<dynamic> filteredDeserts = [];
  List<dynamic> filteredForests = [];
  List<dynamic> filteredTourPlaces = [];

  @override
  void onInit() {
    super.onInit();
    loadData(); 
  }

  // Method to load the JSON data from assets
  Future<void> loadData() async {
    String jsonString = await rootBundle.loadString('assets/cities.json');
    final List<dynamic> citiesData = json.decode(jsonString);

    for (var city in citiesData) {
      if (city['mountains'].isNotEmpty) {
        mountains.add({
          'name': city['mountains'][0]['name'],
          'image': city['mountains'][0]['image'],
          'city': city['name'],
          'location': city['location'],
          'history': city['mountains'][0]['history'], 
        });
      }
      if (city['beaches'].isNotEmpty) {
        beaches.add({
          'name': city['beaches'][0]['name'], 
          'image': city['beaches'][0]['image'] ?? 'assets/default_image.png', 
          'city': city['name'],
          'location': city['location'],
          'history': city['beaches'][0]['history'] ?? '', 
        });
      }
      if (city['deserts'].isNotEmpty) {
        deserts.add({
          'name': city['deserts'][0]['name'],
          'image': city['deserts'][0]['image'],
          'city': city['name'],
          'location': city['location'],
        });
      }
      if (city['forests'].isNotEmpty) {
        forests.add({
          'name': city['forests'][0]['name'],
          'image': city['forests'][0]['image'],
          'city': city['name'],
          'location': city['location'],
        });
      }
      if (city['tour_places'].isNotEmpty) {
        tourPlaces.add({
          'name': city['tour_places'][0]['name'],
          'history': city['tour_places'][0]['history'],
          'city': city['name'],
          'location': city['location'],
          'image': city['image'] ?? 'assets/images/placeholder.png', 
        });
      }
    }

    // Initially set the filtered lists to the full data
    filteredMountains = List.from(mountains);
    filteredBeaches = List.from(beaches);
    filteredDeserts = List.from(deserts);
    filteredForests = List.from(forests);
    filteredTourPlaces = List.from(tourPlaces);

    update(); 
  }

  // Universal search method for all features
  void searchPlaces(String query) {
    filteredMountains = mountains
        .where((mountain) =>
            mountain['name'].toLowerCase().contains(query.toLowerCase()) ||
            mountain['city'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    filteredBeaches = beaches
        .where((beach) =>
            beach['name'].toLowerCase().contains(query.toLowerCase()) ||
            beach['city'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    filteredDeserts = deserts
        .where((desert) =>
            desert['name'].toLowerCase().contains(query.toLowerCase()) ||
            desert['city'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    filteredForests = forests
        .where((forest) =>
            forest['name'].toLowerCase().contains(query.toLowerCase()) ||
            forest['city'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    filteredTourPlaces = tourPlaces
        .where((place) =>
            place['name'].toLowerCase().contains(query.toLowerCase()) ||
            place['city'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    update(); 
  }
}
