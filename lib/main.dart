import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gardienvie/firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/welcom_screen.dart';

<<<<<<< HEAD
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
 runApp(MyApp());
=======
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
>>>>>>> 362c52a4d9d67daa31637a0b5b2412516ac46429
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GardienVie',
      //home: HomeScreen(),
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
