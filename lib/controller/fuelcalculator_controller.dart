import 'package:get/get.dart';

class FuelCalculatorController extends GetxController {
  var distance = 0.0.obs;
  var efficiency = 0.0.obs;
  var price = 0.0.obs;
  var fuelCost = 0.0.obs;

  void calculateFuelCost() {
    if (distance.value > 0 && efficiency.value > 0 && price.value > 0) {
      fuelCost.value = (distance.value / efficiency.value) * price.value;
    } else {
      fuelCost.value = 0.0;
      Get.snackbar(
        'Invalid Input',
        'Please enter valid values for all fields.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void setDistance(String value) {
    distance.value = double.tryParse(value) ?? 0;
  }

  void setEfficiency(String value) {
    efficiency.value = double.tryParse(value) ?? 0;
  }

  void setPrice(String value) {
    price.value = double.tryParse(value) ?? 0;
  }
}
