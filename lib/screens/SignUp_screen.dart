import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gardienvie/screens/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String screenRoute = 'SignUp_screen';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordvrController = TextEditingController();

  Future signUp() async {
    if (passwordvr()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed('auth');
    }
  }

  bool passwordvr() {
    if (_passwordController.text.trim() == _passwordvrController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordvrController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //logo
              const SizedBox(
                height: 180,
                child: CircleAvatar(
                  radius: 100.0,
                  backgroundImage: AssetImage('images/GardienVieLOGOlight.png'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),

              //email
              TextField(
                controller: _emailController,
                textAlign: TextAlign.center,
                onChanged: (value) {},
                decoration: const InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(1000, 109, 12, 12),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              //password
              TextField(
                controller: _passwordController,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {},
                decoration: const InputDecoration(
                  hintText: 'enter Password',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(1000, 109, 12, 12),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              //password   2
              TextField(
                controller: _passwordvrController,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {},
                decoration: const InputDecoration(
                  hintText: 'Renter Password',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(1000, 109, 12, 12),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              //btn
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150),
                child: GestureDetector(
                  onTap: signUp,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(1000, 109, 12, 12),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text("Sign Up"),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              //link to sign in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("already have an account  "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()),
                      );
                    },
                    child: const Text(
                      "sign in here!",
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
