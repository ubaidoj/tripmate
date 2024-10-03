import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TouristPlacesController extends GetxController {
  var cities = <String>[].obs;
  var filteredCities = <String>[].obs;
  var isLoading = false.obs;
  var showCityList = false.obs;
  var searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Load cities on initialization
    loadCities();
  }

  Future<void> loadCities() async {
    isLoading(true);
    final String response = await rootBundle.loadString('assets/cities.json');
    final List<dynamic> data = json.decode(response);

    cities.value = data.map((city) => city['name'] as String).toList();
    filteredCities.value = cities;
    isLoading(false);
  }

  void filterCities(String query) {
    final tempCities = cities.where((city) {
      return city.toLowerCase().contains(query.toLowerCase());
    }).toList();

    filteredCities.value = tempCities;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
