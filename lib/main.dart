import 'package:flutter/material.dart';
import 'login_signup.dart'; // Importing the new login_signup.dart file.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginSignupScreen(), // Set LoginSignupScreen as the initial screen.
    );
  }
}
