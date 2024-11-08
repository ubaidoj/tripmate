// File: pages/dashboard_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(22, 86, 182, 1),
        elevation: 0,
        title: Row(
          children: [
            Obx(() => CircleAvatar(
                  radius: 20,
                  backgroundImage: controller.userProfileImageUrl.isNotEmpty
                      ? FileImage(File(controller.userProfileImageUrl.value))
                      : AssetImage('assets/user_image.png') as ImageProvider,
                )),
            SizedBox(width: 10),
            Obx(() => Text(
                  controller.userName.value,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: controller.goToProfile,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMenuButton(icon: Icons.home, label: 'Home', onPressed: controller.goToHome),
            SizedBox(height: 20),
            _buildMenuButton(icon: Icons.hotel, label: 'Hotel Booking', onPressed: controller.goToHotelBooking),
            SizedBox(height: 20),
            _buildMenuButton(icon: Icons.bookmark, label: 'Saved Locations', onPressed: controller.goToSavedLocations),
            SizedBox(height: 20),
            _buildMenuButton(icon: Icons.location_city, label: 'Cities', onPressed: controller.goToCities),
            SizedBox(height: 20),
            _buildMenuButton(icon: Icons.contact_mail, label: 'Contact Us', onPressed: controller.goToContactUs),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton({required IconData icon, required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blueGrey.shade700,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
