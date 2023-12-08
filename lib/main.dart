import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app_project/providerstate.dart';

import 'package:grocery_app_project/screens/auth_screens/login_screen.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDoqIBFPn8r0du92NHKR1ZTYI-VziNr9SM',
          appId: '1:34658700713:android:eb32760e4b04efc12948b8',
          messagingSenderId: '34658700713',
          projectId: 'todo-github-app-8f8ce'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              title: 'Todo App',
              theme: themeProvider.isDarkMode
                  ? ThemeData.dark(
                      useMaterial3: true,
                    )
                  : ThemeData.light(
                      useMaterial3: true,
                    ),
              debugShowCheckedModeBanner: false,
              home: const LoginScreen(),
            );
          },
        ));
  }
}
