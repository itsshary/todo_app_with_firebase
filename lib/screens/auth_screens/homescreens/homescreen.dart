import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app_project/providerstate.dart';
import 'package:grocery_app_project/screens/auth_screens/homescreens/addtodoscreen.dart';
import 'package:grocery_app_project/screens/auth_screens/login_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = FirebaseFirestore.instance.collection('Todos').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('Todos');
  final _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    Provider.of<ThemeProvider>(context, listen: false).getPreference();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  _auth.signOut().then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                  });
                },
                icon: const Icon(Icons.logout)),
            const SizedBox(
              width: 5.0,
            ),
            Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal,
          title: const Text(
            'Todo List',
          ),
          toolbarHeight: 80.0,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTodoScreen(),
                ));
          },
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: const Icon(
            Icons.add,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: db,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text(
                  'No Data Found',
                  style: TextStyle(fontSize: 20.0),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitFadingCircle(
                color: Colors.teal,
                size: 50.0,
              );
            }

            if (snapshot.hasError) return const Text('Have an Error');

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ListTile(
                      title:
                          Text(snapshot.data!.docs[index]['Tados'].toString()),
                      trailing: IconButton(
                          onPressed: () {
                            ref
                                .doc(
                                    snapshot.data!.docs[index]['id'].toString())
                                .delete();
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
