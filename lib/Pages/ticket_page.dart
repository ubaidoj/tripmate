import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/controller/hotel_controller.dart';

class TicketsPage extends StatelessWidget {
  final HotelController hotelController = Get.find<HotelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Bookings')),
      body: Obx(() {
        return ListView.builder(
          itemCount: hotelController.bookings.length,
          itemBuilder: (context, index) {
            final booking = hotelController.bookings[index];
            return ListTile(
              title: Text('${booking.hotelName} - ${booking.roomType}'),
              subtitle: Text('Status: ${booking.status}'),
              trailing: booking.status == 'Pending'
                  ? ElevatedButton(
                      onPressed: () {
                        hotelController.respondToBooking(index, 'Your booking is confirmed!');
                      },
                      child: Text('Respond'),
                    )
                  : Text('Response: ${booking.response}'),
            );
          },
        );
      }),
    );
  }
}
