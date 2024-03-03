import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/welcom_screen.dart';

void main() {
  // ignore: prefer_const_constructors
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GardienVie',
      // home: HomeScreen(),
      initialRoute: WelcomScreen.screenRoute,
      routes: {
        WelcomScreen.screenRoute: (context) => const WelcomScreen(),
        SignInScreen.screenRoute: (context) => const SignInScreen(),
        RegistrationScreen.screenRoute: (context) => const RegistrationScreen(),
        HomeScreen.screenRoute: (context) => const HomeScreen(),
      },
    );
  }
}
