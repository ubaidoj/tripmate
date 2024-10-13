import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tripmate/Screens/home_page.dart';
import 'package:tripmate/controller/permission_controller.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  PageController pageController = PageController();
  final PermissionController permissionController = Get.put(PermissionController());

  // This method is called when 'Next' or 'Continue' is pressed
  void nextPage(BuildContext context) async {
    if (currentPage.value < 2) {
      currentPage.value++;
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      // Show the permission dialog if the user hasn't granted permission
      bool permissionGranted = await permissionController.checkPermissionStatus();
      if (!permissionGranted) {
        _showPermissionDialog(context); // Call the method to show the dialog
      } else {
        Get.off(HomePage()); // Navigate to HomePage if permission is already granted
      }
    }
  }

  // Shows a dialog box to ask for location permission
  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission Required'),
          content: Text('Please allow location access to proceed.'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Allow'),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                // Request permissions when the user clicks 'Allow'
                bool permissionGranted = await permissionController.requestPermissions();
                if (permissionGranted) {
                  Get.off(HomePage()); // Navigate to HomePage if permission is granted
                } else {
                  Get.snackbar(
                    'Permission Denied',
                    'Location permission is required to proceed.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
