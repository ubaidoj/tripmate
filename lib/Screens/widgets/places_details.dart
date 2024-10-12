import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaceDetailPage extends StatelessWidget {
  final Map place;

  PlaceDetailPage({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(place['image'], width: double.infinity, height: 200, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                place['name'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                place['history'],
                style: TextStyle(fontSize: 16),
              ),
            ),
            // Add more details if necessary
          ],
        ),
      ),
    );
  }
}
