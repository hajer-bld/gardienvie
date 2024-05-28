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
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  static const String screenRoute = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    _model = HomeModel();
    oxytext = oxy.toString();
    temptext = temp.toString();
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
      drawer: drawer(),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
          child: GridView(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
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
        child: Icon(
          Icons.location_on,
          size: 50,
          color: const Color.fromARGB(255, 109, 12, 12),
        ),
      ),
    );
  }

  double oxypercent(double oxy) {
    // Ensure the input number is within the desired range
    if (oxy < 0) {
      return 0.0;
    } else if (oxy > 100) {
      return 1.0;
    } else {
      // Convert the number to a percentage between 0 and 1
      return oxy / 100.0;
    }
  }

  double tempPercent(double temp) {
    // Ensure the input number is within the desired range
    if (temp < 35) {
      return 0.0;
    } else if (temp > 42) {
      return 1.0;
    } else {
      // Convert the number to a percentage between 0 and 1
      return (temp - 35) / 7.0;
    }
  }

  Widget _buildOxymetryCard(BuildContext context) {
    return Container(
      width: 156,
      height: 216,
      decoration: BoxDecoration(
        color: Color(0xFF784242),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
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
              progressColor: Color(0xFF92F3F3),
              backgroundColor: Color(0xFF6D0C0C),
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
                      padding: EdgeInsetsDirectional.fromSTEB(2, 2, 0, 0),
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
        color: Color(0xFF784242),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
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
              progressColor: Color(0xFF92F3F3),
              backgroundColor: Color(0xFF6D0C0C),
              center: Text(
                temptext,
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0,
                    ),
              ),
              barRadius: Radius.circular(40),
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
                      padding: EdgeInsetsDirectional.fromSTEB(2, 2, 0, 0),
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
        color: Color(0xFF784242),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
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
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _getLiveFrequencyData(),
                      isCurved: true,
                      color: const Color(0xFF92F3F3),
                      barWidth: 4,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
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
                      padding: EdgeInsetsDirectional.fromSTEB(2, 2, 0, 0),
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

  List<FlSpot> _getLiveFrequencyData() {
    // This method should return a list of FlSpot objects representing your live frequency data.
    // For demonstration purposes, here's some dummy data:
    return [
      FlSpot(0, 3),
      FlSpot(1, 2),
      FlSpot(2, 5),
      FlSpot(3, 3.1),
      FlSpot(4, 4),
      FlSpot(5, 3),
      FlSpot(6, 4),
    ];
  }

  Widget _buildPressureCard(BuildContext context) {
    return Container(
      width: 156,
      height: 216,
      decoration: BoxDecoration(
        color: Color(0xFF784242),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
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
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _getLivePressureData(),
                      isCurved: true,
                      color: const Color(0xFF92F3F3),
                      barWidth: 4,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
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
                      padding: EdgeInsetsDirectional.fromSTEB(2, 2, 0, 0),
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

  List<FlSpot> _getLivePressureData() {
    // This method should return a list of FlSpot objects representing your live pressure data.
    // For demonstration purposes, here's some dummy data:
    return [
      FlSpot(0, 1),
      FlSpot(1, 3),
      FlSpot(2, 4),
      FlSpot(3, 2),
      FlSpot(4, 5),
      FlSpot(5, 3),
      FlSpot(6, 4),
    ];
  }

  Widget _buildMovementCard(BuildContext context) {
    return Container(
      width: 156,
      height: 216,
      decoration: BoxDecoration(
        color: Color(0xFF784242),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
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
              progressColor: Color(0xFF92F3F3),
              backgroundColor: Color(0xFF6D0C0C),
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
                      padding: EdgeInsetsDirectional.fromSTEB(2, 2, 0, 0),
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
