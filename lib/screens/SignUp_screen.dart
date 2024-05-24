import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gardienvie/screens/signin_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
  bool _saving = false;
  String? _emailError;
  String? _passwordError;
  String? _passwordmatchError;

  Future signUp() async {
    setState(() {
      _saving = true;
      _emailError = null;
      _passwordError = null;
      _passwordmatchError = null;
    });

    if (!passwordvr()) {
      setState(() {
        _passwordmatchError = 'Passwords do not match!';
        _saving = false;
      });
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.of(context).pushNamed('auth');
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'email-already-in-use') {
          _emailError = 'Email is already in use.';
        } else if (e.code == 'invalid-email') {
          _emailError = 'Invalid email address.';
        } else if (e.code == 'weak-password') {
          _passwordError = 'Password is too weak.';
        } else {
          _emailError = 'Sign-up failed. Please try again.';
        }
      });
    } catch (e) {
      setState(() {
        _emailError = 'An error occurred. Please try again.';
      });
    } finally {
      setState(() {
        _saving = false;
      });
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
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Padding(
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
                    backgroundImage:
                        AssetImage('images/GardienVieLOGOlight.png'),
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
                  decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(1000, 109, 12, 12),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    errorText: _emailError,
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
                  decoration: InputDecoration(
                    hintText: 'enter Password',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(1000, 109, 12, 12),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    errorText: _passwordError,
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
                  decoration: InputDecoration(
                    hintText: 'Renter Password',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(1000, 109, 12, 12),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    errorText: _passwordmatchError,
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
      ),
    );
  }
}
