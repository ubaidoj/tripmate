import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tripmate/models/recommended_places_model.dart';

class RecommendedPlacesController extends GetxController {
  var recommendedPlaces = <RecommendedPlaceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecommendedPlaces();
  }

  void loadRecommendedPlaces() async {
    try {
      final String response = await rootBundle.loadString('assets/cities.json');
      final List<dynamic> data = json.decode(response);
      List<RecommendedPlaceModel> places = [];

      for (var city in data) {
        String cityName = city['name'];

        // Load places from each category
        if (city['tour_places'] != null) {
          for (var tourPlace in city['tour_places']) {
            places.add(RecommendedPlaceModel.fromJson(tourPlace, cityName));
          }
        }

        if (city['mountains'] != null) {
          for (var mountain in city['mountains']) {
            places.add(RecommendedPlaceModel.fromJson(mountain, cityName));
          }
        }

        if (city['beaches'] != null) {
          for (var beach in city['beaches']) {
            places.add(RecommendedPlaceModel.fromJson(beach, cityName));
          }
        }

        if (city['forests'] != null) {
          for (var forest in city['forests']) {
            places.add(RecommendedPlaceModel.fromJson(forest, cityName));
          }
        }

        if (city['deserts'] != null) {
          for (var desert in city['deserts']) {
            places.add(RecommendedPlaceModel.fromJson(desert, cityName));
          }
        }
      }

      // Shuffle the places to display different ones each time
      places.shuffle();
      recommendedPlaces.value = places;
    } catch (e) {
      print("Error loading recommended places: $e");
    }
  }

  void refreshPlaces() {
    loadRecommendedPlaces();
  }
}
