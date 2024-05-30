import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gardienvie/auth.dart';
import 'screens/data_screen.dart';
import 'screens/home_screen.dart';
import 'screens/SignUp_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBRl5ZbsFdm3ropf9X2v2SvSndGuYjMxq4",
      appId: "1:771455183307:android:59e26f015372364a886e4e",
      messagingSenderId: "771455183307",
      projectId: "gardienvie-1fe1e",
      authDomain: "gardienvie-1fe1e",
      storageBucket: "gardienvie-1fe1e.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GardienVie',
      // home: HomeScreen(),
      initialRoute: HomeScreen.screenRoute,
      routes: {
        MapScreen.screenRoute: (context) => const MapScreen(),
        SignInScreen.screenRoute: (context) => const SignInScreen(),
        SignUpScreen.screenRoute: (context) => const SignUpScreen(),
        HomeScreen.screenRoute: (context) => const HomeScreen(),
        Auth.screenRoute: (context) => const Auth(),
        DataScreen.screenRoute: (ctx) => DataScreen(),
      },
    );
  }
}
