import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  // Method to check current permission status
  Future<bool> checkPermissionStatus() async {
    var status = await Permission.location.status;
    return status.isGranted;
  }

  // Method to request location permissions
  Future<bool> requestPermissions() async {
    var status = await Permission.location.request();

    return status.isGranted;
  }
}
