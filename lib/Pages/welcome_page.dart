import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/Screens/home_page.dart';
import 'package:tripmate/Screens/onbaording_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  'assets/illustration.png',
                ),
                const SizedBox(height: 40),
                const Text(
                  "Explore your journey \nonly with us",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "All your vacation destinations are here,\nenjoy your holiday",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        // Delay navigation until after the build method completes
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Get.off(() => OnboardingScreen());
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(22, 86, 182, 1),
                        elevation: 0,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 8.0,
                        ),
                      ),
                      child: const Text("Get Started", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
