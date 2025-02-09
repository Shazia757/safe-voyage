import 'package:flutter/material.dart';
import 'package:safe_voyage/community_page.dart';
import 'package:safe_voyage/safety_page.dart';
import 'package:safe_voyage/safe_routes.dart';
import 'home.dart';

class CustomNavBar extends StatelessWidget {
  CustomNavBar({super.key, required this.currentIndex});
  final int currentIndex;
  final pages = [
    HomeScreen(),
    SafeRouteScreen(),
    SafetyRatingsScreen(),
    CommunityScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        if (currentIndex != value) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => pages[value],
          ));
        }
      },
      currentIndex: currentIndex,
      items: <BottomNavigationBarItem>[
        navBarItem("Home", icon: Icon(Icons.home)),
        navBarItem("Safe route", icon: Icon(Icons.place)),
        navBarItem("Destination Safety", icon: Icon(Icons.safety_check)),
        navBarItem("Community", icon: Icon(Icons.group)),
      ],
    );
  }

  BottomNavigationBarItem navBarItem(String label, {required Widget icon}) {
    return BottomNavigationBarItem(
        icon: icon,
        label: label,
        backgroundColor: const Color.fromARGB(255, 3, 56, 116));
  }
}
