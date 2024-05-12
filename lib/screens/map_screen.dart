import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  static const String screenRoute = 'map_screen';

  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    // Retrieve the current user when the widget initializes
    user = FirebaseAuth.instance.currentUser;
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
              // app paramettre  + other users id and kick them
            },
            color: Colors.black,
            icon: const Icon(
              Icons.settings,
              size: 40,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Row(
              children: [Container()],
            )
          ],
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.43296265331129, -122.08832357078792),
          zoom: 19,
        ),
      ),
    );
  }
}
