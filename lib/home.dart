import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fire_auth/login_signup.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String apiKey = 'cGOvygTFng63hv9oRURn0wY3knhlPNwk'; // Replace with your Tomorrow.io API key
  String temperature = 'Loading...';
  String weatherCondition = '';
  IconData weatherIcon = Icons.cloud;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    double lat = 6.9271; // Colombo, Sri Lanka
    double lon = 79.8612;
    String url = 'https://api.tomorrow.io/v4/weather/realtime?location=$lat,$lon&apikey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          temperature = "${data['data']['values']['temperature']}°C";
          int weatherCode = int.parse(data['data']['values']['weatherCode'].toString());
          weatherCondition = getWeatherDescription(weatherCode);
          weatherIcon = getWeatherIcon(weatherCode);
        });
      } else {
        setState(() {
          temperature = 'Error loading data';
        });
      }
    } catch (e) {
      setState(() {
        temperature = 'Failed to fetch data';
      });
    }
  }

  String getWeatherDescription(int code) {
    if (code == 1000) return 'Clear Sky';
    if (code >= 1001 && code <= 1102) return 'Cloudy';
    if (code >= 2000 && code <= 2201) return 'Fog';
    if (code >= 4000 && code <= 4201) return 'Rain';
    if (code >= 5000 && code <= 5101) return 'Snow';
    if (code >= 6000 && code <= 6201) return 'Freezing Rain';
    if (code == 8000) return 'Thunderstorm';
    return 'Unknown';
  }

  IconData getWeatherIcon(int code) {
    if (code == 1000) return Icons.wb_sunny; // Clear Sky
    if (code >= 1001 && code <= 1102) return Icons.cloud; // Cloudy
    if (code >= 2000 && code <= 2201) return Icons.cloud_queue; // Fog
    if (code >= 4000 && code <= 4201) return Icons.beach_access; // Rain
    if (code >= 5000 && code <= 5101) return Icons.ac_unit; // Snow
    if (code >= 6000 && code <= 6201) return Icons.foggy; // Freezing Rain
    if (code == 8000) return Icons.thunderstorm; // Thunderstorm
    return Icons.help_outline; // Unknown
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(weatherIcon, size: 80, color: Colors.orange),
            SizedBox(height: 10),
            Text(
              temperature,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Condition: $weatherCondition',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Icon(Icons.home), onPressed: () {}),
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              IconButton(icon: Icon(Icons.add), onPressed: () {}),
              IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
              IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
