import 'package:flutter/material.dart';
import 'package:gardienvie/screens/registration_screen.dart';
import 'package:gardienvie/screens/signin_screen.dart';

import '/my_widgets/my_button.dart';

class WelcomScreen extends StatefulWidget {
  static const String screenRoute = 'welcom_screen';

  const WelcomScreen({super.key});

  @override
  State<WelcomScreen> createState() => WelcomScreenState();
}

class WelcomScreenState extends State<WelcomScreen> {
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
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage:
                        AssetImage('images/GardienVieLOGOlight.png'),
                  ),
                ),
                Text(
                  'GardienVie',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            mybutton(
              color: Colors.black,
              title: 'Sign In',
              onpressed: () {
                Navigator.pushNamed(context, SignInScreen.screenRoute);
              },
            ),
            mybutton(
              color: Colors.black,
              title: 'register',
              onpressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
