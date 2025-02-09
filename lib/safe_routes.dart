import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:safe_voyage/home.dart';

class SafeRouteScreen extends StatefulWidget {
  @override
  _SafeRouteScreenState createState() => _SafeRouteScreenState();
}

class _SafeRouteScreenState extends State<SafeRouteScreen> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  LatLng _startPoint = LatLng(37.7749, -122.4194); // Default: San Francisco
  LatLng _endPoint = LatLng(37.7849, -122.4094); // Default: Destination
  List<LatLng> safestRoutePoints = [];

  // Dummy safety scores data (example)
  final Map<String, int> safetyScores = {
    'San Francisco': 75,
    'Los Angeles': 80,
    'Miami': 90,
    'New York': 65,
  };

  Future<void> fetchRoute() async {
    final String url =
        "https://router.project-osrm.org/route/v1/driving/${_startPoint.longitude},${_startPoint.latitude};${_endPoint.longitude},${_endPoint.latitude}?geometries=geojson";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List coordinates = jsonData['routes'][0]['geometry']['coordinates'];

      setState(() {
        safestRoutePoints =
            coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
      });
    } else {
      print("Failed to load route");
    }
  }

  Future<void> updateRoute() async {
    // Get coordinates from the "From" and "To" text fields using geocoding
    List<Location> fromLocations =
        await locationFromAddress(_fromController.text);
    List<Location> toLocations = await locationFromAddress(_toController.text);

    if (fromLocations.isNotEmpty && toLocations.isNotEmpty) {
      setState(() {
        // Set the new start and end points
        _startPoint =
            LatLng(fromLocations.first.latitude, fromLocations.first.longitude);
        _endPoint =
            LatLng(toLocations.first.latitude, toLocations.first.longitude);
      });

      // Fetch the new route based on updated coordinates
      fetchRoute();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Safe Route Directions"),
        leading: BackButton(onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          // From and To TextFields
          TextField(
            controller: _fromController,
            decoration: InputDecoration(
              labelText: 'From (Start Location)',
              hintText: 'Enter starting location',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _toController,
            decoration: InputDecoration(
              labelText: 'To (Destination)',
              hintText: 'Enter destination',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
          ),
          SizedBox(height: 20),

          // Button to fetch the route
          FilledButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateColor.resolveWith(
                    (states) => Colors.blue.shade900)),

            onPressed: updateRoute, // Call updateRoute when button is pressed
            child: Text("Get Safe Route"),
          ),

          // Map displaying the safest route
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _startPoint,
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _startPoint,
                      width: 40,
                      height: 40,
                      child:
                          Icon(Icons.location_pin, color: Colors.red, size: 40),
                    ),
                    Marker(
                      point: _endPoint,
                      width: 40,
                      height: 40,
                      child: Icon(Icons.location_pin,
                          color: Colors.blue, size: 40),
                    ),
                  ],
                ),
                if (safestRoutePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: safestRoutePoints,
                        color: Colors.green, // Safe route in green
                        strokeWidth: 5.0,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
