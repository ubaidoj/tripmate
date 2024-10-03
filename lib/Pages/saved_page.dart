import 'package:flutter/material.dart';

class SavedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Places'),
      ),
      body: Center(
        child: Text(
          'You have not saved any places yet!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
