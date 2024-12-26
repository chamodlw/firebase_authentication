import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Login / Signup'),
      ),
      body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
          'Welcome!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: const Text('Login'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignupScreen()),
            );
          },
          child: const Text('Signup'),
          ),
        ],
        ),
      ),
      ),
    );
  }
}
