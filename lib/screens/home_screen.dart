import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../my_widgets/drawer.dart';
import 'data_screen.dart';
import 'package:animator/animator.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

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
      DataSnapshot snapshot = await ref.once() as DataSnapshot;

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
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text('Error fetching location data'),
        ),
      );
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
        backgroundColor: const Color.fromARGB(255, 109, 12, 12),
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
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 0.75,
            ),
            itemCount: 1, // Adjust based on your data
            itemBuilder: (context, index) {
              return Container(
                width: 156,
                height: 216,
                decoration: BoxDecoration(
                  color: const Color(0xFF784242),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Oxymetrie',
                            style: GoogleFonts.inter(
                              color: Theme.of(context).primaryColor,
                              fontSize: 22,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      CircularPercentIndicator(
                        percent: 0.6,
                        radius: 60,
                        lineWidth: 18,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: const Color(0xFF92F3F3),
                        backgroundColor: const Color(0xFF6D0C0C),
                        center: Text(
                          '60%',
                          style: GoogleFonts.sora(
                            color: Theme.of(context).colorScheme.secondary,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '60.65%',
                                style: GoogleFonts.inter(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    2, 2, 0, 0),
                                child: Text(
                                  'SpO2',
                                  style: GoogleFonts.inter(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'last update',
                            style: GoogleFonts.inter(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => selectCategory(context),
        tooltip: 'Increment',
        child: Icon(
          Icons.location_on,
          size: 50,
          color: const Color.fromARGB(255, 109, 12, 12),
        ),
      ),
    );
  }
}
