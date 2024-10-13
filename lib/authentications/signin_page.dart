import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/authentications/auth_controller.dart';
import 'package:tripmate/authentications/signup_page.dart';

class SigninPage extends StatelessWidget {
  // Create the instance using Get.put() to use the controller globally
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome Back')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: authController.emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: authController.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true, // Hide password text
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (authController.emailController.text.isEmpty ||
                    authController.passwordController.text.isEmpty) {
                  Get.snackbar('Error', 'Please fill in all fields');
                } else {
                  authController.login();
                }
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await authController.signInWithGoogle();
                } catch (e) {
                  Get.snackbar('Error', 'Google Sign-In failed: $e');
                }
              },
              child: Text('Sign in with Google'),
            ),
            TextButton(
              onPressed: authController.forgotPassword,
              child: Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: () => Get.to(SignupPage()),
              child: Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
