import 'package:flutter/material.dart';

class CityDetailPage extends StatelessWidget {
  final Map city;

  CityDetailPage({required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(city['image'], width: double.infinity, height: 200, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                city['name'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Location: ${city['location']}",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Tourist Places:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            for (var place in city['tour_places']) ...[
              ListTile(
                title: Text(place['name']),
                subtitle: Text(place['history']),
              ),
            ],
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Mountains: ${city['mountains'].join(', ')}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Beaches: ${city['beaches'].join(', ')}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Forests: ${city['forests'].join(', ')}"),
            ),
          ],
        ),
      ),
    );
  }
}
