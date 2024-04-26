import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gardienvie/screens/SignUp_screen.dart';
import 'package:gardienvie/screens/signin_screen.dart';

class WelcomScreen extends StatefulWidget {
  static const String screenRoute = 'welcom_screen';

  const WelcomScreen({super.key});

  @override
  State<WelcomScreen> createState() => WelcomScreenState();
}

class WelcomScreenState extends State<WelcomScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: const CircleAvatar(
                    radius: 100.0,
                    backgroundImage:
                        AssetImage('images/GardienVieLOGOlight.png'),
                  ),
                ),
                const Text(
                  'GardienVie',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            //sign in
            GestureDetector(
              onTap: () {
                // Navigate to the sign-in screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(1000, 109, 12, 12),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Text("Sign In"),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            //sign up
            GestureDetector(
              onTap: () {
                // Navigate to the sign-up screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(1000, 109, 12, 12),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Text("Sign Un"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
