import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SignUp_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  static const String screenRoute = 'signin_screen';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool spinner = false;
  String? _emailError;
  String? _passwordError;
  String _generalErrorMessage = '';

  Future signIn() async {
    setState(() {
      spinner = true;
      _emailError = null;
      _passwordError = null;
      _generalErrorMessage = '';
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      setState(() {
        spinner = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _emailError = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          _passwordError = 'Wrong password provided.';
        } else {
          _generalErrorMessage = e.message ?? 'An error occurred';
        }
        spinner = false;
      });
    } catch (e) {
      setState(() {
        _generalErrorMessage = 'An error occurred. Please try again.';
        spinner = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //the pic
                Container(
                  height: 180,
                  child: const CircleAvatar(
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
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
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
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
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
                  height: 15,
                ),
                //button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: GestureDetector(
                    onTap: signIn,
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
                ),

                const SizedBox(
                  height: 10,
                ),
                if (_generalErrorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      _generalErrorMessage,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                //sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("don't have an account  "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text(
                        "sign up now !",
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
