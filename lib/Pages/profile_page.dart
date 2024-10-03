import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/authcontroller.dart';

class ProfilePage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.isLoggedIn.value) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.dashboard),
                title: Text('Dashboard'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text('Saved'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text('Rate Us'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.contact_mail),
                title: Text('Contact Us'),
                onTap: () {},
              ),
            ],
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Sign In page
                  },
                  child: Text('Sign In'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Sign Up page
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
