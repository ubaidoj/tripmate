// File: controller/dashboard_controller.dart
import 'package:get/get.dart';
import 'package:tripmate/Pages/city_list.dart';
import 'package:tripmate/Pages/contact_us.dart';
import 'package:tripmate/Pages/hotel_list.dart';
import 'package:tripmate/Pages/saved_page.dart';
import 'package:tripmate/Screens/home_page.dart';
import 'package:tripmate/authentications/auth_controller.dart';
import 'package:tripmate/authentications/profile_page.dart';

class DashboardController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  // Observes the userName and profileImageUrl from AuthController directly
  RxString get userName => authController.userName;
  RxString get userProfileImageUrl => authController.profileImageUrl;

  void goToProfile() {
    Get.to(ProfilePage());
    
  }

  void goToHome() {
    Get.to(HomePage());
  }

  void goToHotelBooking() {
    Get.to(HotelListPage());
  }

  void goToSavedLocations() {
    Get.to(SavedLocationPage());
  }

  void goToCities() {
    Get.to(CityListPage());
  }

  void goToContactUs() {
    Get.to(ContactUsScreen());
  }
}
