import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gardienvie/auth.dart';
import 'package:gardienvie/firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/SignUp_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
      initialRoute: SignInScreen.screenRoute,
      routes: {
        MapScreen.screenRoute: (context) => const MapScreen(),
        SignInScreen.screenRoute: (context) => const SignInScreen(),
        SignUpScreen.screenRoute: (context) => const SignUpScreen(),
        HomeScreen.screenRoute: (context) => const HomeScreen(),
        Auth.screenRoute: (context) => const Auth(),
      },
    );
  }
}
