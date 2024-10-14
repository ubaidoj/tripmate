import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/fuelcalculator_controller.dart';

class FuelCalculatorScreen extends StatelessWidget {
  final FuelCalculatorController controller = Get.put(FuelCalculatorController());
  final String distance;

  FuelCalculatorScreen({required this.distance}) {
    controller.setDistance(distance);
  }

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
              controller: TextEditingController(text: distance),
              onChanged: controller.setDistance,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Fuel Efficiency (km/l or miles/gallon)'),
              onChanged: controller.setEfficiency,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Fuel Price (per liter or gallon)'),
              onChanged: controller.setPrice,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.calculateFuelCost,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Obx(() {
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
