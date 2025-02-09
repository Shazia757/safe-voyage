import 'dart:developer';

import 'package:get_storage/get_storage.dart';

class TempData {
  final List<Map<String, dynamic>> userList = [
    {
      'name': 'Alice Johnson',
      'email': 'alice.johnson@example.com',
      'password': 'alice123'
    },
    {'name': 'smith', 'email': 'bob.smith@example.com', 'password': 'bob123'},
    {
      'name': 'Charlie Brown',
      'email': 'charlie.brown@example.com',
      'password': 'charlie123'
    },
    {
      'name': 'smith',
      'email': 'diana.prince@example.com',
      'password': 'diana123'
    },
    {
      'name': 'Ethan Hunt',
      'email': 'ethan.hunt@example.com',
      'password': 'ethan123'
    }
  ];
}

class LocalDB {
  final _db = GetStorage();
  writeProfileData(Map<String, dynamic> data) {
    _db.write("Profile", data);
  }

  Map<String, dynamic> readProfileData() {
    return _db.read("Profile") as Map<String, dynamic>;
  }

  addUser(Map<String, dynamic> data) {
    List<Map<String, dynamic>> list = readUsersList();
    list.add(data);
    _db.write("Users", list);
  }

  List<Map<String, dynamic>> readUsersList() {
    try {
      return _db.read("Users") ?? [];
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  void clearDB() {
    _db.remove("Users");
  }
}

class SafetyScoreService {
  final Map<String, Map<String, double>> safetyData = {
    "New York": {"crimeRate": 7.5, "nightSafety": 6.0},
    "Los Angeles": {"crimeRate": 6.2, "nightSafety": 7.2},
    "San Francisco": {"crimeRate": 8.0, "nightSafety": 5.5},
    "Chicago": {"crimeRate": 7.8, "nightSafety": 6.8},
    "Miami": {"crimeRate": 6.5, "nightSafety": 7.0}
  };

  // Method to calculate the safety score based on crime rate & night safety
  double calculateSafetyScore(String city) {
    if (safetyData.containsKey(city)) {
      double crimeRate = safetyData[city]!["crimeRate"]!;
      double nightSafety = safetyData[city]!["nightSafety"]!;
      return 100 - (crimeRate * 10) + (nightSafety * 5);
    }
    return 75.0; // Default safety score if city is not found
  }
}
