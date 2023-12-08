import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app_project/componets/componetsbutton.dart';
import 'package:grocery_app_project/firebase_helper/utilis.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController addcontroller = TextEditingController();
  final db = FirebaseFirestore.instance.collection('Todos');
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      progressIndicator: const SpinKitFadingCircle(
        color: Colors.teal,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: const Text(
            'Add Todo',
          ),
          toolbarHeight: 80.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextFormField(
                controller: addcontroller,
                decoration: const InputDecoration(
                  hintText: 'Enter Some Todo',
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ComponetButton(
                text: 'Add Todo',
                onpress: () async {
                  setState(() {
                    isloading = true;
                  });
                  //using uuid package for unique id generating
                  DateTime timedate = DateTime.now();
                  String id = DateTime.now().microsecondsSinceEpoch.toString();
                  db.doc(id).set({
                    'Tados': addcontroller.text.toString(),
                    'time': timedate,
                    'id': id,
                  }).then((value) {
                    setState(() {
                      isloading = false;
                    });
                    Utilis().fluttertoast('Your Todo Added Successfully');
                    Navigator.pop(context);
                  }).onError((error, stackTrace) {
                    setState(() {
                      isloading = false;
                    });
                    Utilis().fluttertoast(error.toString());
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
