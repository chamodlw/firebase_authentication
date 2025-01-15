import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import '../styles/predefstyles.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(17, 142, 245, 1),
            Color.fromARGB(255, 93, 195, 242),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                ClipRRect(
                borderRadius: BorderRadius.circular(100.0), // Set the radius here
                child: Image.asset('assets/images/weather.png',
                height: 200.0,), // Add the image here
                ),
              const SizedBox(height: 20),
              const Text(
                'WeatherWise',
                style: TextStyle(
                  fontFamily: 'JosefinSans', // Matches the family name in pubspec.yaml
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
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
                child: const Text('Get Start', style: PredefStyles.bodyText),
              ),
              const SizedBox(height: 8),
                ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent.withOpacity(0.1),
                    shadowColor: Colors.transparent.withOpacity(0.1),
                ),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                  );
                },
                child: const Text('Create Account', style: PredefStyles.bodyText2, ),
                ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
