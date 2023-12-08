import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app_project/firebase_helper/utilis.dart';
import 'package:grocery_app_project/screens/auth_screens/homescreens/homescreen.dart';

import '../../componets/componetsbutton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SigningScreen extends StatefulWidget {
  const SigningScreen({super.key});

  @override
  State<SigningScreen> createState() => _SigningScreenState();
}

class _SigningScreenState extends State<SigningScreen> {
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
      color: Colors.black,
      progressIndicator: const SpinKitFadingCircle(
        color: Colors.teal,
        size: 50.0,
      ),
      inAsyncCall: isloading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Signing Screen',
                style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
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
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: passwordcon,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Password';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Password'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ComponetButton(
                        onpress: () {
                          signup();
                        },
                        text: 'Signing Here',
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

//signing function

  void signup() {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });

      _auth
          .createUserWithEmailAndPassword(
              email: emailcon.text.toString(),
              password: passwordcon.text.toString())
          .then((value) {
        setState(() {
          Utilis().fluttertoast('User Succesfully Signing');
          isloading = false;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        });
      }).onError((error, stackTrace) {
        setState(() {
          isloading = false;
        });

        Utilis().fluttertoast(error.toString());
      });
    }
  }
}
