import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gardienvie/screens/home_screen.dart';
import 'package:gardienvie/screens/signin_screen.dart';

class Auth extends StatelessWidget {
  static const String screenRoute = 'auth';
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return SignInScreen();
          }
        }),
      ),
    );
  }
}
