import "package:flutter/material.dart";
import '../app_data.dart';
import '../my_widgets/data_item.dart';

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
      body: GridView(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 7 / 8,
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
    );
  }
}
