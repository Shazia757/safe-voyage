import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:safe_voyage/data.dart';

class SignupPage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 56, 116),
        leading: BackButton(
          color: Colors.white,
        ),
        actions: [
          TextButton(
              onPressed: () {
                LocalDB().clearDB();
              },
              child: Text(
                "Clear DB",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign Up",
            style: TextStyle(
                fontSize: 24,
                color: const Color.fromARGB(255, 3, 56, 116),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text("Username")),
                controller: usernameController),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text("Email")),
                controller: emailController),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Password")),
              controller: passwordController,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 25, left: 8, right: 8),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Confirm Password")),
              controller: confirmpasswordController,
            ),
          ),
          FilledButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateColor.resolveWith(
                      (states) => const Color.fromARGB(255, 3, 56, 116))),
              onPressed: () {
                if (passwordController.text == confirmpasswordController.text) {
                  LocalDB().addUser({
                    'name': usernameController.text,
                    'email': emailController.text,
                    'password': passwordController.text,
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Success!")));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password Not Matching")));
                }
                log(LocalDB().readUsersList().toString());
              },
              child: Text("SIGN UP"))
        ],
      ),
    );
  }
}
