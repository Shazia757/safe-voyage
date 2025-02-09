import 'package:flutter/material.dart';
import 'package:safe_voyage/custom_widgets.dart';
import 'package:safe_voyage/home.dart'; // Ensure CustomNavBar exists

class SafetyRatingsScreen extends StatefulWidget {
  @override
  _SafetyRatingsScreenState createState() => _SafetyRatingsScreenState();
}

class _SafetyRatingsScreenState extends State<SafetyRatingsScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Preloaded safety data
  final List<Map<String, dynamic>> safetyData = [
    {
      "city": "New York",
      "safetyScore": 75,
      "crimeRate": "High",
      "riskAlert": "🚨 Caution in some areas"
    },
    {
      "city": "Los Angeles",
      "safetyScore": 80,
      "crimeRate": "Moderate",
      "riskAlert": "⚠️ Avoid downtown at night"
    },
    {
      "city": "San Francisco",
      "safetyScore": 70,
      "crimeRate": "High",
      "riskAlert": "🚨 High risk in Tenderloin area"
    },
    {
      "city": "Chicago",
      "safetyScore": 65,
      "crimeRate": "Very High",
      "riskAlert": "🚨 Stay alert in certain districts"
    },
    {
      "city": "Miami",
      "safetyScore": 85,
      "crimeRate": "Low",
      "riskAlert": "✅ Generally safe, but be cautious at night"
    },
  ];

  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();
    filteredData = List.from(safetyData); // Show all cities initially
  }

  void searchCity(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredData = List.from(safetyData);
      } else {
        filteredData = safetyData
            .where((element) => element['city']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Safety Ratings"),
          leading: BackButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ))),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search for a city...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onChanged: searchCity,
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(10),
                      color: Colors.blue[100],
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("📍 ${filteredData[index]['city']}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text(
                                "⭐ Safety Score: ${filteredData[index]['safetyScore']}",
                                style: TextStyle(fontSize: 18)),
                            Text(
                                "🔍 Crime Rate: ${filteredData[index]["crimeRate"]}",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(height: 10),

                            // Risk Alert
                            Text(
                              filteredData[index]["riskAlert"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: filteredData[index]['safetyScore'] < 70
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            CustomNavBar(currentIndex: 2), //  Integrated bottom navigation
      ),
    );
  }
}
