import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NearbyPlacesController extends GetxController {
  var nearbyPlaces = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNearbyPlaces();
  }

  Future<void> fetchNearbyPlaces() async {
    isLoading(true);
    final String apiUrl = 'http://my-tourist-spots.vercel.app/api/tourist-spots';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['spots'] != null) {
        nearbyPlaces.value = data['spots'].map((place) {
          return {
            'name': place['name'],
            'image': place['image'],
            'location': "${place['location']['district']}, ${place['location']['province']}, ${place['location']['country']}",
            'category': place['category'],
          };
        }).toList();
      }
    } else {
      // Handle error
      print('Failed to load nearby places');
    }

    isLoading(false);
  }
}
