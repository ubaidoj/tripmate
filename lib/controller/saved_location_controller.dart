import 'package:get/get.dart';

class SavedLocationController extends GetxController {
  // List of saved locations
  final RxList<Map<String, dynamic>> savedLocations = <Map<String, dynamic>>[].obs;

  // Function to add a location
  void addLocation(String name, String location, String image) {
    savedLocations.add({
      'name': name,
      'location': location,
      'image': image,
    });
  }

  // Function to check if a location is saved
  bool isLocationSaved(String name) {
    return savedLocations.any((item) => item['name'] == name);
  }
}
