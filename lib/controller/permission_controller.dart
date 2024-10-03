import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:tripmate/Screens/home_page.dart';

class PermissionController extends GetxController {
  Future<void> requestPermissionsAndNavigate() async {
    var status = await [
      Permission.microphone,
      Permission.storage,
    ].request();

    if (status[Permission.microphone]!.isGranted &&
        status[Permission.storage]!.isGranted && status[Permission.camera]!.isGranted) {
      Get.to(() => HomePage());
    } else {
      Get.snackbar(
        'Permissions required',
        'Please grant all permissions to proceed.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
