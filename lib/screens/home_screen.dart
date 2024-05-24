import "package:flutter/material.dart";
import '../app_data.dart';
import '../my_widgets/data_item.dart';
import 'package:animator/animator.dart';

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
      body: Column(
        children: [
          Animator<double>(
            tween: Tween<double>(begin: 0, end: 1), // Animation range
            duration: Duration(seconds: 1),
            builder: (context, animatorState, child) => Transform.scale(
              scale: animatorState.value,
              child: child,
            ),
            // Widget to animate
          ),
          Expanded(
            child: GridView(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 1 / 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              children: Data_data.map(
                (datadata) => DataItem(
                  datadata.data,
                  datadata.imageUrl,
                  datadata.id,
                  datadata.title,
                ),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
