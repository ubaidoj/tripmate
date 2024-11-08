import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tripmate/Pages/contact_us.dart';
import 'package:tripmate/Pages/dashboard_screen.dart';
import 'package:tripmate/Pages/hotel_list.dart';
import 'package:tripmate/Screens/widgets/customicon_buttton.dart';
import 'package:tripmate/Screens/widgets/location_card.dart';
import 'package:tripmate/Screens/widgets/nearby_places.dart';
import 'package:tripmate/Screens/widgets/recommended_places.dart';
import 'package:tripmate/Screens/widgets/tourist_places.dart';
import 'package:tripmate/Screens/widgets/map_card.dart';
import 'package:tripmate/authentications/auth_controller.dart';
import 'package:tripmate/authentications/profile_page.dart';
import 'package:tripmate/authentications/signin_page.dart';
import 'package:tripmate/controller/home_controller.dart';
import 'package:tripmate/Pages/saved_page.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: homeController.checkLocationPermission(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || (snapshot.hasData && !snapshot.data!)) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Location permission is required to access this page."),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Go Back"),
                  ),
                ],
              ),
            ),
          );
        }

        return _buildHomePageContent(context);
      },
    );
  }

  Widget _buildHomePageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(22, 86, 182, 1),
        foregroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Good Morning", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              "From Team TripMate",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
            ),
          ],
        ),
        actions: [
          CustomIconButton(
            icon: const Icon(Ionicons.search_outline),
            onPressed: () {},
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
            return HomeContent();
          case 1:
            return HotelListPage();
          case 2:
            return SavedLocationPage();
          case 3:
            return ProfilePage();
          default:
            return HomeContent();
        }
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: homeController.selectedIndex.value,
          onTap: (index) {
            homeController.updateIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromRGBO(22, 86, 182, 1),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Ionicons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.bed),
              label: "Ticket",
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.bookmark),
              label: "Saved",
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.person),
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
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Ionicons.grid),
            title: Text('DashBoard'),
            onTap: () {
              Get.to(() => DashboardScreen());
            },
          ),
          ListTile(
            leading: Icon(Ionicons.home),
            title: Text('Home'),
            onTap: () {
              homeController.updateIndex(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Ionicons.person),
            title: Text('Profile'),
            onTap: () {
              homeController.updateIndex(3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Ionicons.bed),
            title: Text('Hotel Booking'),
            onTap: () {
              Get.to(HotelListPage());
            },
          ),
          ListTile(
            leading: Icon(Ionicons.ticket),
            title: Text('Tickets'),
            onTap: () {
              homeController.updateIndex(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Ionicons.call),
            title: Text('Contact Us'),
            onTap: () {
              Get.to(() => ContactUsScreen());
            },
          ),
          ListTile(
            leading: Icon(Ionicons.star),
            title: Text('Rate Us'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Ionicons.bookmark),
            title: Text('Saved Locations'),
            onTap: () {
              homeController.updateIndex(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Ionicons.log_out),
            title: Text('Log out'),
            onTap: () async {
              await authController.signOut();
              Get.offAll(() => SignInScreen());
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
    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(14),
            children: [
              const LocationCard(),
              const SizedBox(height: 15),
              MapCard(),
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
              RecommendedPlaces(),
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
                height: 250,
                child: NearbyPlaces(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
