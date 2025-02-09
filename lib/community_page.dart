import 'dart:math';

import 'package:flutter/material.dart';
import 'package:safe_voyage/custom_widgets.dart';
import 'package:safe_voyage/data.dart';
import 'package:safe_voyage/home.dart';
import 'package:safe_voyage/login_screen.dart';

class CommunityScreen extends StatelessWidget {
  List<Map<String, dynamic>> userList = [];
  CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    userList = LocalDB().readUsersList();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
          ),
        ],
        leading: BackButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              )),
        ),
        title: Text("Find My Buddy"),
      ),
      bottomNavigationBar: CustomNavBar(currentIndex: 3),
      body: ListView.separated(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return ListTile(
              trailing: Text("${Random().nextInt(100)} km away"),
              title: Text(userList[index]['name']),
              subtitle: Text(userList[index]['email']),
              leading: Icon(Icons.person));
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}
