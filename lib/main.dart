import 'package:flutter/material.dart';
import 'Pages/GetStarted.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Getstarted(), // Use the separated OnboardingScreen
      debugShowCheckedModeBanner: false, // Hide the debug banner
    );
  }
}

