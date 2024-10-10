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

      // Shuffle the data to display different places each time
      data.shuffle();

      // Map the loaded JSON data to the RecommendedPlaceModel
      recommendedPlaces.value = List<RecommendedPlaceModel>.from(
        data.map((place) => RecommendedPlaceModel.fromJson(place)),
      );
    } catch (e) {
      print("Error loading recommended places: $e");
    }
  }

  void refreshPlaces() {
    loadRecommendedPlaces();
  }
}
