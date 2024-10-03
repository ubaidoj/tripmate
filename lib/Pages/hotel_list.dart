import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/Pages/hotel_details.dart';
import 'package:tripmate/controller/hotel_controller.dart';

class HotelListPage extends StatelessWidget {
  final HotelController hotelController = Get.put(HotelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hotel List',
          style: TextStyle(
            color: const Color.fromARGB(255, 10, 87, 151),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by hotel name or location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                hotelController.filterHotels(value);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (hotelController.isLoading.value) {
                // Show loader while data is loading
                return Center(child: CircularProgressIndicator());
              }

              if (hotelController.filteredHotels.isEmpty) {
                // Show message if no hotels found
                return Center(child: Text("No hotels found"));
              }

              return ListView.builder(
                itemCount: hotelController.filteredHotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotelController.filteredHotels[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to HotelDetailsPage
                      Get.to(() => HotelDetailsPage(hotel: hotel));
                    },
                    child: Card(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.20, // 20% of screen height
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      hotel.name,
                                      style: TextStyle(
                                        color: const Color.fromARGB(255, 8, 98, 172),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[700],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      '⭐ ${hotel.rating ?? 0.0}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Hotel Image
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Image.asset(
                                hotel.image,
                                width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Hotel Location
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      hotel.location,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
