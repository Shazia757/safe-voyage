import 'package:flutter/material.dart';
import 'package:safe_voyage/data.dart';
import 'package:safe_voyage/home.dart';
import 'package:safe_voyage/signup_page.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 11, 59, 113),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 3, vertical: 190),
            color: Colors.blue[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "asset/icon.jpg",
                      height: 100,
                    ),
                  ),
                ),
                Text(
                  "Safe Voyage",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                      fontFamily: "Arial"),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Username"),
                      ),
                      controller: usernameController),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), label: Text("Password")),
                    controller: passwordController,
                  ),
                ),
                FilledButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateColor.resolveWith(
                            (states) => Colors.blue.shade900)),
                    onPressed: () {
                      try {
                        final user = LocalDB().readUsersList().firstWhere(
                            (element) =>
                                element['name'] == usernameController.text);
                        if (user['password'] == passwordController.text) {
                          LocalDB().writeProfileData(user);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Password Incorrect")));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Invalid user")));
                      }
                    },
                    child: Text("LOGIN")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignupPage()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 15, color: Colors.blue[900]),
                    ))
              ],
            ),
          ),
        ));
  }
}
