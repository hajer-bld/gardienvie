import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
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
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  String oxytext = '0';
  String temp = '0';
  String frec = '0';
  String press = '0';
  String latitude = '0';
  String longitude = '0';
  late HomeModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = HomeModel();
    fetchData();
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

  Future<void> fetchData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    Future<void> fetchData() async {
      final DatabaseReference ref = FirebaseDatabase.instance.ref();

      // Get references to data nodes
      final oxyRef = ref.child('oxy');
      final tempRef = ref.child('temp');
      final frecRef = ref.child('frec');
      final pressRef = ref.child('press');
      final locationRef = ref.child('location');
      final latitudeRef = locationRef.child('latitude');
      final longitudeRef = locationRef.child('longitude');

      // Listen for data changes
      oxyRef.onValue.listen((event) {
        final oxyValue =
            event.snapshot.value as double?; // Cast to double (nullable)
        if (oxyValue != null) {
          setState(() {
            oxy = oxyValue.toString(); // Convert to String for display
          });
        }
      });
      tempRef.onValue.listen((event) {
        final tempValue =
            event.snapshot.value as double?; // Cast to double (nullable)
        if (tempValue != null) {
          setState(() {
            temp = tempValue.toString(); // Convert to String for display
          });
        }
      });
      frecRef.onValue.listen((event) {
        final frecValue =
            event.snapshot.value as double?; // Cast to double (nullable)
        if (frecValue != null) {
          setState(() {
            frec = frecValue.toString(); // Convert to String for display
          });
        }
      });
      pressRef.onValue.listen((event) {
        final pressValue =
            event.snapshot.value as double?; // Cast to double (nullable)
        if (pressValue != null) {
          setState(() {
            press = pressValue.toString(); // Convert to String for display
          });
        }
      });
      latitudeRef.onValue.listen((event) {
        final latitudeValue =
            event.snapshot.value as double?; // Cast to double (nullable)
        if (latitudeValue != null) {
          setState(() {
            latitude =
                latitudeValue.toString(); // Convert to String for display
          });
        }
      });
      longitudeRef.onValue.listen((event) {
        final longitudeValue =
            event.snapshot.value as double?; // Cast to double (nullable)
        if (longitudeValue != null) {
          setState(() {
            longitude =
                longitudeValue.toString(); // Convert to String for display
          });
        }
      });
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
  }

  double oxypercent(String oxyValue) {
    double oxy = double.tryParse(oxyValue) ?? 0.0;
    if (oxy < 0) {
      return 0.0;
    } else if (oxy > 100) {
      return 1.0;
    } else {
      return oxy / 100.0;
    }
  }

  double frecpercent(String frecValue) {
    double frec = double.tryParse(frecValue) ?? 0.0;
    if (frec < 50) {
      return 0.0;
    } else if (frec > 120) {
      return 1.0;
    } else {
      return (frec - 50) / 70.0;
    }
  }

  double presspercent(String pressValue) {
    double press = double.tryParse(pressValue) ?? 0.0;
    if (press < 50) {
      return 0.0;
    } else if (press > 120) {
      return 1.0;
    } else {
      return (press - 50) / 70.0;
    }
  }

  double temppercent(String tempValue) {
    double temp = double.tryParse(tempValue) ?? 0.0;
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
              percent: oxypercent(oxyValue),
              radius: 66,
              lineWidth: 18,
              animation: true,
              animateFromLastPercent: true,
              progressColor: const Color(0xFF92F3F3),
              backgroundColor: const Color(0xFF6D0C0C),
              center: Text(
                oxy,
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
                      oxy,
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
              percent: temppercent(temp),
              lineHeight: 34,
              animation: true,
              animateFromLastPercent: true,
              progressColor: const Color(0xFF92F3F3),
              backgroundColor: const Color(0xFF6D0C0C),
              center: Text(
                temp,
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
                      temp,
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
                temp,
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
                temp,
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
        onPressed: () =>
            launchMaps(double.parse(latitude), double.parse(longitude)),
        tooltip: 'Location',
        child: const Icon(
          Icons.location_on,
          size: 50,
          color: Color.fromARGB(255, 109, 12, 12),
        ),
      ),
    );
  }
}
