import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/Screens/home_page.dart';
import 'package:tripmate/controller/permission_controller.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  PageController pageController = PageController();

  void nextPage() {
    if (currentPage.value < 2) {
      currentPage.value++;
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      final PermissionController permissionController =
          Get.put(PermissionController());

      permissionController.requestPermissionsAndNavigate();

      Get.off(HomePage());
    }
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
