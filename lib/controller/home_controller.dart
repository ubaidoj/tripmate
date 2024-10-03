import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  // Example data, replace with your actual data
  var places = ["Paris", "London", "Tokyo", "New York", "Sydney"]; // Static list now

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}
 