// File: pages/contact_us_screen.dart
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(22, 86, 182, 1),
        title: Text('Contact Us', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get in Touch',
              style: TextStyle(color: Color.fromRGBO(22, 86, 182, 1), fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Email: contact@tripmate.com',
              style: TextStyle(color: Color.fromRGBO(22, 86, 182, 1), fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Phone: +123 456 7890',
              style: TextStyle(color: Color.fromRGBO(22, 86, 182, 1), fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Address: 123 TripMate St, Adventure City',
              style: TextStyle(color: Color.fromRGBO(22, 86, 182, 1), fontSize: 16),
            ),
            SizedBox(height: 30),
            Text(
              'We are here to help you plan the perfect trip. If you have any questions, feel free to reach out to us!',
              style: TextStyle(color: Color.fromRGBO(22, 86, 182, 1), fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
