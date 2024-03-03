import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/welcom_screen.dart';

void main() {
// runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GardienVie',
      // home: HomeScreen(),
      initialRoute: WelcomScreen.screenRoute,
      routes: {
        WelcomScreen.screenRoute: (context) => WelcomScreen(),
        SignInScreen.screenRoute: (context) => SignInScreen(),
        RegistrationScreen.screenRoute: (context) => RegistrationScreen(),
        HomeScreen.screenRoute: (context) => HomeScreen(),
      },
    );
  }
}
