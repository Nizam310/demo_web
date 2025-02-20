import 'package:flutter/material.dart';
import 'package:image_app/home/home.dart'; // Imports the Home screen from another file

void main() {
  runApp(const MyApp()); // Entry point of the Flutter app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // Hides the debug banner in the app
        theme: ThemeData(
          useMaterial3:
              false, // Disables Material 3 design system (keeps Material 2 styling)
        ),
        title: 'Image App', // Sets the app title
        home: const Home()); // Sets the initial screen of the app
  }
}
