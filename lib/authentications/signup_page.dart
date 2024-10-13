import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/authentications/auth_controller.dart';
import 'package:tripmate/authentications/signin_page.dart';

class SignupPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up to TripMate')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create Your Account', style: TextStyle(fontSize: 22)),
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () => authController.pickImage(),
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
            ),
            SizedBox(height: 20),
            TextField(
              controller: authController.firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: authController.lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: authController.emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: authController.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 10),
            TextField(
              controller: authController.confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authController.signup(); // Calls signup method
              },
              child: Text('Sign Up'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await authController.signInWithGoogle(); // Calls signInWithGoogle
              },
              child: Text('Sign in with Google'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => Get.to(SigninPage()),
              child: Text('Already have an account? Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
