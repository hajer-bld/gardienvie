import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../screens/signin_screen.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.only(top: 40),
            alignment: Alignment.center,
            color: Color.fromARGB(1000, 109, 12, 12),
            child: Text(
              'Parameter\nWeekly Overview',
              style: TextStyle(
                color: Color.fromARGB(1000, 109, 12, 12),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          parim("Sign Out", Icons.close, () {
            _auth.signOut();
            Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil(
              SignInScreen.screenRoute,
              (route) => false,
            );
          }),
        ],
      ),
      /* ListView(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      SignInScreen.screenRoute,
                      (route) => false,
                    );
                  },
                  icon: Icon(Icons.close))
            ],
          )
        ],
      ),*/
    );
  }

  ListTile parim(String title, IconData icon, void Function()? onTaplink) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: Color.fromARGB(1000, 109, 12, 12),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
      ),
      onTap: onTaplink,
    );
  }
}
