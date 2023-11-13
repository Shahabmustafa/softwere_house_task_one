import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PassengerMap extends StatefulWidget {
  const PassengerMap({Key? key}) : super(key: key);

  @override
  State<PassengerMap> createState() => _PassengerMapState();
}

class _PassengerMapState extends State<PassengerMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // Initial map position
          zoom: 12.0,
        ),
      ),
    );
  }
}
