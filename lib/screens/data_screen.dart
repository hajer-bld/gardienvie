import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  static const String screenRoute = 'Data_Screen';
  final user = FirebaseAuth.instance.currentUser;

  DataScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        user != null
            ? Text(
                user!.email!,
                style: const TextStyle(fontSize: 20),
              )
            : const Text(
                'No user signed in',
                style: TextStyle(fontSize: 20),
              ),
      ]),
    );
  }
}
