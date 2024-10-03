import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tripmate/Pages/tourplaces/deserts_details.dart';
import 'package:tripmate/Pages/tourplaces/feature_controller.dart';

class DesertsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FeatureController controller = Get.put(FeatureController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true, // Centers the title
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centers the row content
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                'assets/icons/back_icon.svg', // Fix the SVG path
                height: 24.0,
                width: 24.0,
                color: Colors.blue[900], // Ensures color matches the theme
              ),
            ),
            Spacer(), // Pushes the title to the center
            Text(
              'Deserts',
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 20,
                fontWeight: FontWeight.bold, // Makes the title bold
              ),
            ),
            Spacer(), // Ensures the title stays centered
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                controller.searchPlaces(value); // Calls the universal search method
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.blue[900]),
                hintText: 'Search by city or desert name...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue[900]!),
                ),
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<FeatureController>(
              builder: (controller) {
                if (controller.filteredDeserts.isEmpty) {
                  return Center(child: Text("No results found."));
                }
                return ListView.builder(
                  itemCount: controller.filteredDeserts.length,
                  itemBuilder: (context, index) {
                    final desert = controller.filteredDeserts[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DesertsDetails(desert: desert));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 5.0)
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Left-aligns the mountain name
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        desert['name'],
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        desert['city'],
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Image.asset(
                                    desert['image'],
                                    height: 100,
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
