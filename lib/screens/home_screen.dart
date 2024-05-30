import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../my_widgets/drawer.dart';
import 'data_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'homemodel.dart';
export 'homemodel.dart';

class HomeScreen extends StatefulWidget {
  static const String screenRoute = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late HomeModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double temp = 36;
  late String temptext;
  double oxy = 100;
  late String oxytext;
  double frec = 100;
  late String frectext;
  double press = 100;
  late String presstext;

  @override
  void initState() {
    super.initState();
    _model = HomeModel();
    oxytext = oxy.toString();
    temptext = temp.toString();
    frectext = frec.toString();
    presstext = press.toString();
    initializeFirebase();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> location(BuildContext ctx) async {
    try {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref().child('locations');

      DataSnapshot snapshot = await ref.get();

      if (snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            snapshot.value as Map<dynamic, dynamic>?;
        if (values != null && values.isNotEmpty) {
          var lastEntry = values.entries.first;
          double latitude = lastEntry.value['latitude'];
          double longitude = lastEntry.value['longitude'];
          await launchMaps(latitude, longitude);
        } else {
          throw 'Location not available';
        }
      }
    } catch (e) {
      print('Error fetching location: $e');
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text('Location not available'),
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
      key: scaffoldKey,
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
      drawer: const drawer(),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
          child: GridView(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.65,
            ),
            scrollDirection: Axis.vertical,
            children: [
              _buildOxymetryCard(context),
              _buildTemperatureCard(context),
              _buildFrequencyCard(context),
              _buildPressureCard(context),
              _buildMovementCard(context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => location(context),
        tooltip: 'Location',
        child: const Icon(
          Icons.location_on,
          size: 50,
          color: Color.fromARGB(255, 109, 12, 12),
        ),
      ),
    );
  }

  double oxypercent(double oxy) {
    if (oxy < 0) {
      return 0.0;
    } else if (oxy > 100) {
      return 1.0;
    } else {
      return oxy / 100.0;
    }
  }

  double frecpercent(double frec) {
    if (oxy < 0) {
      return 0.0;
    } else if (oxy > 100) {
      return 1.0;
    } else {
      return oxy / 100.0;
    }
  }

  double presspercent(double press) {
    if (oxy < 0) {
      return 0.0;
    } else if (oxy > 100) {
      return 1.0;
    } else {
      return oxy / 100.0;
    }
  }

  double tempPercent(double temp) {
    if (temp < 35) {
      return 0.0;
    } else if (temp > 42) {
      return 1.0;
    } else {
      return (temp - 35) / 7.0;
    }
  }

  Widget _buildOxymetryCard(BuildContext context) {
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
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        fontSize: 22,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            CircularPercentIndicator(
              percent: oxypercent(oxy),
              radius: oxy,
              lineWidth: 18,
              animation: true,
              animateFromLastPercent: true,
              progressColor: const Color(0xFF92F3F3),
              backgroundColor: const Color(0xFF6D0C0C),
              center: Text(
                oxy.toString(),
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Sora',
                      color: FlutterFlowTheme.of(context).alternate,
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
                      oxy.toString(),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 24,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 0, 0),
                      child: Text(
                        'SpO2',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              fontSize: 16,
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'last update',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).primaryBackground,
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
  }

  Widget _buildTemperatureCard(BuildContext context) {
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
                  'Temperature',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        fontSize: 22,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            LinearPercentIndicator(
              percent: tempPercent(temp),
              lineHeight: 34,
              animation: true,
              animateFromLastPercent: true,
              progressColor: const Color(0xFF92F3F3),
              backgroundColor: const Color(0xFF6D0C0C),
              center: Text(
                temptext,
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0,
                    ),
              ),
              barRadius: const Radius.circular(40),
              padding: EdgeInsets.zero,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      temptext,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 24,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 0, 0),
                      child: Text(
                        '°C',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              fontSize: 16,
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'last update',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).primaryBackground,
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
  }

  Widget _buildFrequencyCard(BuildContext context) {
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
                  'Frequence',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        fontSize: 22,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            LinearPercentIndicator(
              percent: frecpercent(frec),
              lineHeight: 34,
              animation: true,
              animateFromLastPercent: true,
              progressColor: const Color(0xFF92F3F3),
              backgroundColor: const Color(0xFF6D0C0C),
              center: Text(
                temptext,
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0,
                    ),
              ),
              barRadius: const Radius.circular(40),
              padding: EdgeInsets.zero,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '50-120',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 24,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 0, 0),
                      child: Text(
                        'bpm',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              fontSize: 16,
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'last update',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).primaryBackground,
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
  }

  Widget _buildPressureCard(BuildContext context) {
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
                  'Pression',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        fontSize: 22,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            LinearPercentIndicator(
              percent: presspercent(press),
              lineHeight: 34,
              animation: true,
              animateFromLastPercent: true,
              progressColor: const Color(0xFF92F3F3),
              backgroundColor: const Color(0xFF6D0C0C),
              center: Text(
                temptext,
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0,
                    ),
              ),
              barRadius: const Radius.circular(40),
              padding: EdgeInsets.zero,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '50-120',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 24,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 0, 0),
                      child: Text(
                        'bpm',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              fontSize: 16,
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'last update',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).primaryBackground,
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
  }

  Widget _buildMovementCard(BuildContext context) {
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
                  'Mouvement',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        fontSize: 22,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            CircularPercentIndicator(
              percent: 0.3,
              radius: 60,
              lineWidth: 18,
              animation: true,
              animateFromLastPercent: true,
              progressColor: const Color(0xFF92F3F3),
              backgroundColor: const Color(0xFF6D0C0C),
              center: Text(
                '30%',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Sora',
                      color: FlutterFlowTheme.of(context).alternate,
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
                      '50-120',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 24,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 0, 0),
                      child: Text(
                        'bpm',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              fontSize: 16,
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'last update',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme.of(context).primaryBackground,
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
  }
}
