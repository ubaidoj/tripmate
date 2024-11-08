import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:tripmate/controller/fuelcalculator_controller.dart';

class FuelCalculatorScreen extends StatelessWidget {
  final String distance;
  final FuelCalculatorController controller = Get.put(FuelCalculatorController());

  // Define TextEditingControllers for each text field
  final TextEditingController distanceController;
  final TextEditingController priceController = TextEditingController();
  final TextEditingController efficiencyController = TextEditingController();

  FuelCalculatorScreen({required this.distance})
      : distanceController = TextEditingController(text: distance) {
    controller.setDistance(distance); // Set the distance value once on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          'Fuel Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTextField(
              title: 'Distance (km):',
              hint: 'Enter Total Distance to be Covered',
              controller: distanceController,
              onChanged: controller.setDistance,
            ),
            SizedBox(height: 20),
            _buildTextField(
              title: 'Price per liter (Pkr):',
              hint: 'Enter Fuel Price per Liter In Your Area',
              controller: priceController,
              onChanged: controller.setPrice,
            ),
            SizedBox(height: 20),
            _buildTextField(
              title: 'Fuel consumption (liters per km):',
              hint: 'Fuel Consumption Of Your Vehicle per KM',
              controller: efficiencyController,
              onChanged: controller.setEfficiency,
            ),
            SizedBox(height: 20),
            Obx(() {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (controller.distance.value > 0 &&
                          controller.efficiency.value > 0 &&
                          controller.price.value > 0)
                      ? controller.calculateFuelCost
                      : null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text(
                    'Calculate',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              return Text(
                controller.fuelCost.value > 0
                    ? 'You need ${(controller.distance.value * controller.efficiency.value).toStringAsFixed(2)} liters of fuel, costing Pkr${controller.fuelCost.value.toStringAsFixed(2)}'
                    : 'You need 0.00 liters of fuel, costing Pkr0.00',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              );
            }),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.setDistance('0');
                  controller.setEfficiency('0');
                  controller.setPrice('0');
                  controller.fuelCost.value = 0;

                  distanceController.clear();
                  priceController.clear();
                  efficiencyController.clear();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromRGBO(22, 86, 182, 1),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  'Reset',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String title,
    required String hint,
    required Function(String) onChanged,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          onChanged: onChanged,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
        ),
      ],
    );
  }
}
