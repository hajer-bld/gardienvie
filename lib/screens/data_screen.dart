import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  final String theId;
  final String theTitle;
  DataScreen(this.theId, this.theTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          theTitle,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(1000, 109, 12, 12),
        centerTitle: true,
      ),
      body: Center(
        child: Text('last 24 hour data'),
      ),
    );
  }
}
