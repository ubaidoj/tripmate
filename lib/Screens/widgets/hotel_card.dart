/* import 'package:flutter/material.dart';
import 'package:tripmate/models/hotel_model.dart';

class HotelCard extends StatelessWidget {
  final Hotel hotel;

  HotelCard({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hotel.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('Price: \$${hotel.pricePerNight} / night'),
            SizedBox(height: 5),
            Text('Location: ${hotel.location}'),
          ],
        ),
      ),
    );
  }
} */