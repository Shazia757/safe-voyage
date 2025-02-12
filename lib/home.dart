import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:safe_voyage/community_page.dart';
import 'package:safe_voyage/custom_widgets.dart';
import 'package:safe_voyage/data.dart';
import 'package:safe_voyage/safe_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
      ),
      bottomNavigationBar: CustomNavBar(currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // User Greeting & Safety Score
            Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'asset/profile.png',
                  height: 60,
                ),
              ),
              SizedBox(width: 16),
              Text(
                'Welcome, ${LocalDB().readProfileData()['name']} !',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 3, 56, 116)),
              ),
            ]),

            // Safety Score Card
            SizedBox(height: 20),
            Card(
              elevation: 2,
              child: ListTile(
                title: Text('Safety Score',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                subtitle: Text(
                  'Current safety score for your location:',
                  style: TextStyle(fontSize: 15),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        '${SafetyScoreService().calculateSafetyScore('Chicago')}',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                    Text('out of 100'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Quick Access Menu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Safe Route Navigation Button
                FeatureButton(
                  icon: Icons.directions_walk,
                  label: 'Safe Routes',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SafeRouteScreen(),
                        ));
                  },
                ),
                // Find a Buddy Button
                FeatureButton(
                  icon: Icons.group,
                  label: 'Find a Buddy',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommunityScreen(),
                        ));
                  },
                )
              ],
            ),
            SizedBox(height: 20),
            // Safety Alerts Section
            Card(
              elevation: 2,
              child: ListTile(
                title: Text('Safety Alerts',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                subtitle: Text(
                  'Get alerts for any nearby incidents.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: IconButton.filled(
                icon: Icon(
                  Icons.alarm,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmergencyScreen()));
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  backgroundColor: Colors.red[900],

                  // Button color
                ),
              ),
            ),
            Center(
                child: Text("Emergency SOS", style: TextStyle(fontSize: 14))),
          ],
        ),
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const FeatureButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            backgroundColor:
                const Color.fromARGB(255, 3, 56, 116), // Button color
          ),
          child: Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}

class EmergencyScreen extends StatelessWidget {
  void sendSOS(double lat, double long) async {
    final Uri smsUri =
        Uri.parse('sms:+1234567890?body=Emergency! I need help!');
    try {
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emergency SOS")),
      body: Column(
        children: [
          Text(
            "On clicking this button, your real-time location will be instantly sent to both your buddies and emergency contacts, ensuring quick assistance in emergencies. 🚨📍",
            maxLines: 5,
          ),
          ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Location shared to nearby buddies")));
              },
              child: Text("Send SOS")),
        ],
      ),
    );
  }
}
