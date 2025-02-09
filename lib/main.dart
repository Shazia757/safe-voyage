import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_voyage/data.dart';
import 'package:safe_voyage/home.dart';
import 'package:safe_voyage/login_screen.dart';
import 'package:safe_voyage/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}

