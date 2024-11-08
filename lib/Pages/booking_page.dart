import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/hotel_controller.dart';
import 'package:tripmate/models/hotel_model.dart';
import 'package:tripmate/models/room_model.dart';

class BookingPage extends StatelessWidget {
  final Hotel hotel;
  final Room room;
  final HotelController hotelController = Get.find<HotelController>();
  final TextEditingController messageController = TextEditingController();

  BookingPage({required this.hotel, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book ${room.type} at ${hotel.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: messageController,
              decoration: InputDecoration(labelText: 'Enter your message'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                hotelController.bookRoom(hotel, room, messageController.text);
                Get.snackbar('Booking Request Sent', 'Your booking request has been sent to ${hotel.name}');
                Get.back();
              },
              child: Text('Book Room'),
            ),
          ],
        ),
      ),
    );
  }
}
