import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app_project/firebase_helper/utilis.dart';
import 'package:grocery_app_project/screens/auth_screens/homescreens/homescreen.dart';
import 'package:grocery_app_project/screens/auth_screens/signing_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../componets/componetsbutton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailcon = TextEditingController();
  final passwordcon = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool isloading = false;
  @override
  void dispose() {
    super.dispose();
    emailcon.dispose();
    passwordcon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      color: Colors.black,
      progressIndicator: const SpinKitFadingCircle(
        color: Colors.teal,
        size: 50.0,
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/1.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailcon,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Email'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: passwordcon,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Password';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Password'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ComponetButton(
                        onpress: () {
                          loginFun();
                        },
                        text: 'Login',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Don't have an accout"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SigningScreen(),
                                  ));
                            },
                            child: const Text(
                              'Signing Here',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void loginFun() {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      _auth
          .signInWithEmailAndPassword(
              email: emailcon.text, password: passwordcon.text)
          .then((value) {
        setState(() {
          isloading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }).onError((error, stackTrace) {
        setState(() {
          isloading = false;
        });
        Utilis().fluttertoast(error.toString());
      });
    }
  }
}
