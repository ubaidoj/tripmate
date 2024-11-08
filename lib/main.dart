// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/authentications/auth_controller.dart';
import 'package:tripmate/Pages/welcome_page.dart';
import 'package:tripmate/authentications/signup_page.dart';
import 'package:tripmate/controller/saved_location_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  Get.put(SavedLocationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TripMate',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: AuthChecker(),
    );
  }
}

class AuthChecker extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authController.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData) {
          return WelcomePage();
        }
        return SignUpScreen();
      },
    );
  }
}
