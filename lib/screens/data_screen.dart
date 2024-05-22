import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  static const String screenRoute = 'Data_Screen';
  //final String theId;
  //final String theTitle;
  //DataScreen(this.theId, this.theTitle);

  @override
  Widget build(BuildContext context) {
    final root =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final dataId = root['id'];
    final dataTitle = root['title'];
    return Scaffold(
      appBar: AppBar(
        title: Text(dataTitle!),
        backgroundColor: const Color.fromARGB(1000, 109, 12, 12),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return;
        },
        // itemCount: ,
      ),
    );
  }
}
