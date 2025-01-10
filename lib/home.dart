import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire_auth/login_signup.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Add your logout logic here
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginSignupScreen()),
                );
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  // Add your home button logic here
                },
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Add your search button logic here
                },
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // Add your add button logic here
                },
              ),
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  // Add your notifications button logic here
                },
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  // Add your profile button logic here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}