import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/data_screen.dart';

class DataItem extends StatelessWidget {
  final String id;
  final String title;
  final String data;
  final String imageUrl;

  DataItem(this.data, this.imageUrl, this.id, this.title);

  void slectCategory(BuildContext ctx) {
    _fetchAndLaunchLocation(ctx);
  }

  Future<void> _fetchAndLaunchLocation(BuildContext context) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref('locations');
      DataSnapshot snapshot = (await ref.once()) as DataSnapshot;

      if (snapshot.value != null) {
        Map? values = snapshot.value as Map<dynamic, dynamic>?;
        if (values != null && values.isNotEmpty) {
          var lastEntry = values.entries.first;
          double latitude = lastEntry.value['latitude'] as double;
          double longitude = lastEntry.value['longitude'] as double;
          _launchMaps(latitude, longitude);
        } else {
          throw 'No location data available';
        }
      } else {
        throw 'No location data available';
      }
    } catch (e) {
      print('Error fetching location: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching location data'),
      ));
    }
  }

  void _launchMaps(double latitude, double longitude) async {
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
    return InkWell(
      onTap: () => slectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(19),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(19),
            child: Image.asset(
              imageUrl,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
