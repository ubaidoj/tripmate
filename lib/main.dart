import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:tripmate/Pages/welcome_page.dart';
import 'package:tripmate/authentications/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that the Flutter engine is initialized
  await Firebase.initializeApp(); 
  runApp(const MyApp());
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: WelcomePage(),  // Set the initial screen
    );
  }
}
