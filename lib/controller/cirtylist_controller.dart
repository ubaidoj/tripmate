import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CityListController extends GetxController {
  var cities = [].obs;  // Observable list for city data

  @override
  void onInit() {
    super.onInit();
    loadCitiesFromJson();  // Load the cities when the controller is initialized
  }

  // Load city data from the JSON file
  Future<void> loadCitiesFromJson() async {
    final String response = await rootBundle.loadString('assets/cities.json');
    final data = json.decode(response);
    cities.value = data;
  }
}
