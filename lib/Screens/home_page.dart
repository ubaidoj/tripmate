import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tripmate/Pages/hotel_list.dart';
import 'package:tripmate/Screens/widgets/customicon_buttton.dart';
import 'package:tripmate/Screens/widgets/location_card.dart';
import 'package:tripmate/Screens/widgets/nearby_places.dart';
import 'package:tripmate/Screens/widgets/recommended_places.dart';
import 'package:tripmate/Screens/widgets/tourist_places.dart';
import 'package:tripmate/Screens/widgets/map_card.dart';
import 'package:tripmate/authentications/profile_page.dart';
import 'package:tripmate/controller/home_controller.dart';
import 'package:tripmate/Pages/ticket_page.dart';
import 'package:tripmate/Pages/saved_page.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: homeController.checkLocationPermission(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while checking permission
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError || (snapshot.hasData && !snapshot.data!)) {
          // If permission is not granted, show a message or redirect
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Location permission is required to access this page."),
                  ElevatedButton(
                    onPressed: () {
                      Get.back(); // Redirect user back to the previous page
                    },
                    child: Text("Go Back"),
                  ),
                ],
              ),
            ),
          );
        }

        // If permission is granted, display the home page
        return _buildHomePageContent(context);
      },
    );
  }

  Widget _buildHomePageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the drawer
            },
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Good Morning"),
            Text(
              "Tetteh Jeron Asiedu",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        actions: [
          CustomIconButton(
            icon: const Icon(Ionicons.search_outline),
            onPressed: () {
              // Handle search button press
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 12),
            child: CustomIconButton(
              icon: const Icon(Ionicons.notifications_outline),
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Obx(() {
        switch (homeController.selectedIndex.value) {
          case 0:
            return HomeContent(); // Main home page content
          case 1:
            return TicketPage(); // Navigate to TicketPage
          case 2:
            return SavedPage(); // Navigate to SavedPage
          case 3:
            return ProfilePage(); // Navigate to ProfilePage
          default:
            return HomeContent();
        }
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: homeController.selectedIndex.value,
          onTap: (index) {
            homeController.updateIndex(index); // Trigger refresh or navigation
          },
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Ionicons.home_outline),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.ticket_outline),
              label: "Ticket",
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.bookmark_outline),
              label: "Saved",
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.person_outline),
              label: "Profile",
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(22, 86, 182, 1),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Ionicons.grid_outline),
            title: Text('DashBoard'),
            onTap: () {
              // Get.to(() => Dashboard());
            },
          ),
          ListTile(
            leading: Icon(Ionicons.home_outline),
            title: Text('Home'),
            onTap: () {
              homeController.updateIndex(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Ionicons.person_outline),
            title: Text('Profile'),
            onTap: () {
              homeController.updateIndex(3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Ionicons.restaurant_outline),
            title: Text('Hotel Booking'),
            onTap: () {
              Get.to(HotelListPage());
            },
          ),
          ListTile(
            leading: Icon(Ionicons.ticket_outline),
            title: Text('Tickets'),
            onTap: () {
              homeController.updateIndex(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Ionicons.call_outline),
            title: Text('Contact Us'),
            onTap: () {
              // Get.to(() => ContactPage());  // Example navigation
            },
          ),
          ListTile(
            leading: Icon(Ionicons.star_outline),
            title: Text('Rate Us'),
            onTap: () {
              // Add your rate us functionality
            },
          ),
          ListTile(
            leading: Icon(Ionicons.bookmark_outline),
            title: Text('Saved Locations'),
            onTap: () {
              homeController.updateIndex(2);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(  // Use Column instead of Expanded to structure the widgets properly
      children: [
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(14),
            children: [
              const LocationCard(),
              const SizedBox(height: 15),
              MapCard(), // Add the MapCard here
              const SizedBox(height: 15),
              TouristPlaces(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommendation",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(onPressed: () {}, child: const Text("View All")),
                ],
              ),
              const SizedBox(height: 10),
              RecommendedPlaces(), // Display dynamic recommended places here
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nearby From You",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(onPressed: () {}, child: const Text("View All")),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250, // Adjust the height as needed to ensure the ListView inside NearbyPlaces has proper size
                child: NearbyPlaces(), // Display nearby places here
              ),
            ],
          ),
        ),
      ],
    );
  }
}
