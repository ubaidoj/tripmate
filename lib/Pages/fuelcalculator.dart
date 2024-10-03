import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/fuelcalculator_controller.dart';

class FuelCalculatorScreen extends StatelessWidget {
  final FuelCalculatorController controller = Get.put(FuelCalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fuel Charge Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Distance (in km or miles)'),
              onChanged: controller.setDistance, // Update distance in controller
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Fuel Efficiency (km/l or miles/gallon)'),
              onChanged: controller.setEfficiency, // Update efficiency in controller
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Fuel Price (per liter or gallon)'),
              onChanged: controller.setPrice, // Update price in controller
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.calculateFuelCost, // Calculate fuel cost
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Obx(() {
              // Reactively update the UI when fuelCost changes
              return Text(
                controller.fuelCost.value > 0
                    ? 'Fuel Charge: \$${controller.fuelCost.value.toStringAsFixed(2)}'
                    : 'Fuel Charge: \$0.00',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }),
          ],
        ),
      ),
    );
  }
}
