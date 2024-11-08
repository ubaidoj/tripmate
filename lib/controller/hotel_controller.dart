import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tripmate/models/hotel_model.dart';
import 'package:tripmate/models/booking_model.dart';
import 'package:tripmate/models/room_model.dart';

class HotelController extends GetxController {
  var hotels = <Hotel>[].obs;
  var filteredHotels = <Hotel>[].obs;
  var isLoading = true.obs;
  var bookings = <Booking>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHotels();
  }

  void loadHotels() async {
    try {
      final String response = await rootBundle.loadString('assets/hotel_data.json');
      final List<dynamic> data = json.decode(response);
      hotels.value = data.map((json) => Hotel.fromJson(json)).toList();
      filteredHotels.value = hotels;
      isLoading.value = false;
    } catch (e) {
      print("Error loading hotel data: $e");
      isLoading.value = false;
    }
  }

  void filterHotels(String query) {
    if (query.isEmpty) {
      filteredHotels.value = hotels;
    } else {
      filteredHotels.value = hotels.where((hotel) {
        final nameLower = hotel.name.toLowerCase();
        final locationLower = hotel.location.toLowerCase();
        final searchLower = query.toLowerCase();
        return nameLower.contains(searchLower) || locationLower.contains(searchLower);
      }).toList();
    }
  }

  void bookRoom(Hotel hotel, Room room, String userMessage) {
    Booking newBooking = Booking(
      hotelName: hotel.name,
      roomType: room.type,
      price: room.price,
      status: 'Pending',
      userMessage: userMessage,
    );
    bookings.add(newBooking);
  }

  void respondToBooking(int index, String response) {
    bookings[index].response = response;
    bookings[index].status = 'Responded';
    bookings.refresh();
  }
}
