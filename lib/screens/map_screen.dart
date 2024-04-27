import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  static const String screenRoute = 'map_screen';

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Google Map'),
      ),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(37.43296265331129, -122.08832357078792), zoom: 19),
      ),
    );
  }
}
