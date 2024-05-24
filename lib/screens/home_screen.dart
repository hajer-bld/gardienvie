import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../my_widgets/drawer.dart';
import 'data_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String screenRoute = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Future<void> selectCategory(BuildContext ctx) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref('locations');
      DataSnapshot snapshot = (await ref.once()) as DataSnapshot;
      ;

      if (snapshot.value != null) {
        Map? values = snapshot.value as Map<dynamic, dynamic>?;
        if (values != null && values.isNotEmpty) {
          var lastEntry = values.entries.first;
          double latitude = lastEntry.value['latitude'] as double;
          double longitude = lastEntry.value['longitude'] as double;
          await launchMaps(latitude, longitude);
        } else {
          throw 'No location data available';
        }
      }
    } catch (e) {
      print('Error fetching location: $e');
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text('Error fetching location data'),
      ));
    }
  }

  Future<void> launchMaps(double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GardienVie',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(1000, 109, 12, 12),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DataScreen()),
              );
            },
            color: Colors.black,
            icon: const Icon(
              Icons.person,
              size: 40,
            ),
          ),
        ],
      ),
      drawer: drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => selectCategory(context),
        tooltip: 'Increment',
        child: Icon(Icons.location_on,
            size: 50, color: Color.fromARGB(1000, 109, 12, 12)),
      ),
    );
  }
}
