import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  // Check if location permission is granted
  Future<bool> checkLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      return true;
    } else {
      // Request permission if not granted
      return await Permission.location.request().isGranted;
    }
  }

  // Method to update selected index
  void updateIndex(int index) {
    if (selectedIndex.value == index && index == 0) {
      refreshHomePage();
    } else {
      selectedIndex.value = index;
    }
  }

  // Logic to refresh the home page
  void refreshHomePage() {
    selectedIndex.refresh();
  }
}
