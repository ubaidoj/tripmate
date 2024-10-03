import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tripmate/controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  Widget _buildOnboardingPage(
      BuildContext context, String image, String title, String subtitle, List<Color> colors) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.25,
          left: screenWidth * 0.2,
          child: Container(
            width: screenWidth * 0.6,
            height: screenHeight * 0.4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: colors,
                stops: [0.3, 0.3],
                center: Alignment.center,
                radius: 0.85,
                focal: Alignment.center,
                focalRadius: 0.1,
              ),
            ),
            child: Center(
              child: ClipOval(
                child: Image.asset(
                  image,
                  width: screenWidth * 0.42,  // Reduced image size to 70% of the circle width
                  height: screenWidth * 0.42,  // Match the width to keep it rounded
                  fit: BoxFit.cover,  // Ensures the image fits within the circle
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.65,
          left: (screenWidth - (screenWidth * 0.4)) / 2,
          child: Container(
            width: screenWidth * 0.4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(22, 86, 182, 1),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.68,
          left: screenWidth * 0.05,
          child: Container(
            width: screenWidth * 0.9,
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Prevent going back to the splash screen
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(

                    context,
                    'assets/onboarding_${index + 1}.png',
                    ['Explore Tourism?', 'Hotel Booking?', 'TripMate Family!'][index],
                    [
                      'Dive into a world where every sunrise feels like a new beginning, and every destination calls you to fall in love with the unknown!',
                      'Find a place that feels like home, whether you are seeking a cozy corner or a luxury escape — because every journey deserves a perfect stay!',
                      'Together, we’re more than just travelers — we’re family!'
                    ][index],
                    [
                      [Color(0xFFFDB7C5), Color.fromRGBO(93, 148, 232, 1),],  
                      [Color(0xFFFDEE89), Color.fromARGB(255, 212, 183, 22)],  
                      [Color(0xFFB5EAD7), Color.fromARGB(255, 50, 233, 148)],  
                    ][index],
                  );
                },
                onPageChanged: (index) {
                  controller.currentPage.value = index;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: controller.pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Color.fromRGBO(22, 86, 182, 1),
                      dotColor: Colors.grey[300]!,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8,
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(() => _buildNextButton(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: controller.nextPage,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: Color.fromRGBO(22, 86, 182, 1),
        fixedSize: Size(screenWidth * 0.9, 48),
      ),
      child: Text(
        controller.currentPage.value == 2 ? 'Continue' : 'Next',
        style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
      ),
    );
  }
}
