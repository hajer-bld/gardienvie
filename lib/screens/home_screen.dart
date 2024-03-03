import "package:flutter/material.dart";

class HomeScreen extends StatefulWidget {
  static const String screenRoute = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GardienVie',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(1000, 109, 12, 12),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // user's profile + other users names
          },
          color: Colors.black,
          icon: Icon(
            Icons.account_circle,
            size: 40,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // app paramettre  + other users id and kick them
            },
            color: Colors.black,
            icon: Icon(
              Icons.settings,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
