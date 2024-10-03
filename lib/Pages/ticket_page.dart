import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Tickets'),
      ),
      body: Center(
        child: Text(
          'No tickets available yet!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
