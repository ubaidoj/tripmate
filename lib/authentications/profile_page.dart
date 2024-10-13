import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/authentications/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authController.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: authController.pickImage, // Trigger pick image
              child: Obx(() {
                return CircleAvatar(
                  radius: 50,
                  backgroundImage: authController.profileImage.value != null
                      ? FileImage(authController.profileImage.value!)
                      : AssetImage('assets/profile_placeholder.png')
                          as ImageProvider,
                );
              }),
            ),
            SizedBox(height: 20),
            Text(
              'Name: ${authController.user?.displayName ?? 'No name provided'}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${authController.user?.email ?? 'No email provided'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: authController.updateProfile,
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
