import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fire_auth/login_signup.dart';
import 'package:geolocator/geolocator.dart'; // Import geolocator package
import '../styles/predefstyles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String apiKey =
      'cGOvygTFng63hv9oRURn0wY3knhlPNwk'; // Replace with your Tomorrow.io API key
  String temperature = 'Loading...';
  String weatherCondition = '';
  IconData weatherIcon = Icons.cloud;
  User? user;
  double? latitude;
  double? longitude;
  String humidity = 'Loading...';
  String cloudCover = 'Loading...';
  String windSpeed = 'Loading...';
  bool showMoreData = false;

  @override
  void initState() {
    super.initState();
    fetchLocation(); // Fetch user's location
    getUserDetails();
  }

  // Function to get user's current location
  Future<void> fetchLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // If location services are disabled, show a message and return
      setState(() {
        temperature = 'Location services are disabled.';
      });
      return;
    }

    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          temperature = 'Location permission denied.';
        });
        return;
      }
    }

    // Get current position (latitude and longitude)
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    // Fetch weather data once location is available
    if (latitude != null && longitude != null) {
      fetchWeather(latitude!, longitude!);
    }
  }

  Future<void> fetchWeather(double lat, double lon) async {
    String url =
        'https://api.tomorrow.io/v4/weather/realtime?location=$lat,$lon&apikey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          temperature = "${data['data']['values']['temperature']}°C";
          int weatherCode =
              int.parse(data['data']['values']['weatherCode'].toString());
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

  // Get user details from Firebase Auth
  void getUserDetails() {
    final currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      user = currentUser;
    });
  }

  Future<void> fetchAdditionalWeatherData() async {
    String url =
        'https://api.tomorrow.io/v4/weather/realtime?location=$latitude,$longitude&apikey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          temperature = "${data['data']['values']['temperature']}°C";
          int weatherCode =
              int.parse(data['data']['values']['weatherCode'].toString());
          weatherCondition = getWeatherDescription(weatherCode);
          weatherIcon = getWeatherIcon(weatherCode);
          humidity = "${data['data']['values']['humidity']}%";
          cloudCover = "${data['data']['values']['cloudCover']}%";
          windSpeed = "${data['data']['values']['windSpeed']} km/h";
          showMoreData = true;
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' '),
        backgroundColor: Color.fromRGBO(17, 142, 245, 1), // Set the color of the AppBar
        actions: [
          IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => LoginSignupScreen()),
            );
          });
        },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(17, 142, 245, 1),
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 15),
                Text(
                  'Current Report',
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Weather display section with border
                SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 206, 203, 198), width: 2),
                  borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  child: Column(
                  children: [
                    Icon(weatherIcon, size: 80, color: Colors.orange),
                    SizedBox(height: 10),
                    Text(
                    temperature,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                    weatherCondition.isNotEmpty ? '$weatherCondition Time' : '',
                    style: TextStyle(fontSize: 18),
                    ),
                    
                  ],
                  ),
                ),
                SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        // display additional weather data
                        await fetchAdditionalWeatherData();
                        if (showMoreData) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Center(
                                  child: Text(
                                  'Weather Report',
                                  style: PredefStyles.heading1,
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                  Row(
                                    children: [
                                    Icon(Icons.thermostat, color: Colors.orange),
                                    SizedBox(width: 10),
                                    Text(
                                      'Temperature: $temperature',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                    Icon(Icons.water_drop, color: Colors.blue),
                                    SizedBox(width: 10),
                                    Text(
                                      'Humidity: $humidity',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                    Icon(Icons.cloud, color: Colors.grey),
                                    SizedBox(width: 10),
                                    Text(
                                      'Cloud Cover: $cloudCover',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                    Icon(Icons.air, color: Colors.green),
                                    SizedBox(width: 10),
                                    Text(
                                      'Wind Speed: $windSpeed',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  ],
                                ),
                                
                              );
                            },
                          );
                        }
                      },
                      child: Text('More', style: TextStyle(color: Colors.blue),),
                    ),
              ],
            ),
          ),
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
