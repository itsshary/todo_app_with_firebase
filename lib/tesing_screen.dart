// import 'package:flutter/material.dart';
// import 'package:grocery_app_project/providerstate.dart';
// import 'package:provider/provider.dart';

// //This is a theme changing screen code
// class TestingScreen extends StatefulWidget {
//   const TestingScreen({super.key});

//   @override
//   State<TestingScreen> createState() => _TestingScreenState();
// }

// class _TestingScreenState extends State<TestingScreen> {
//   void initState() {
//     super.initState();
//     Provider.of<ThemeProvider>(context, listen: false).getPreference();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(
//       context,
//     );
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Testing screen'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             themeProvider.toggleTheme();
//           },
//           child: Text(themeProvider.isDarkMode
//               ? 'Switch to Light Mode'
//               : 'Switch to Dark Mode'),
//         ),
//       ),
//     );
//   }
// }
