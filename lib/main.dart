import 'package:flutter/material.dart';
import 'login_signup.dart'; // Importing the new login_signup.dart file.
import 'package:firebase_core/firebase_core.dart'; // Importing the firebase_core package.

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginSignupScreen(), // Set LoginSignupScreen as the initial screen.
    );
  }
}
