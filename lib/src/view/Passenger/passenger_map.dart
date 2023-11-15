import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_app/src/style/app_color.dart';

class PassengerMap extends StatefulWidget {
  const PassengerMap({Key? key}) : super(key: key);

  @override
  State<PassengerMap> createState() => _PassengerMapState();
}

class _PassengerMapState extends State<PassengerMap> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(37.7749, -122.4194), // Initial map position
            zoom: 12.0,
          ),
          zoomControlsEnabled: false,
        ),
        floatingActionButton: buildSpeedDial(),
      ),
    );
  }
  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 28.0),
      backgroundColor: AppColor.blackColor,
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        SpeedDialChild(
          child: Icon(Icons.location_on, color: Colors.red),
          backgroundColor: AppColor.blackColor,
          onTap: () => print('Pressed Read Later'),
          label: 'Current Location',
          labelStyle:
          TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: Icon(Icons.travel_explore, color: Colors.white),
          backgroundColor: AppColor.blackColor,
          onTap: () => print('Pressed Write'),
          label: 'Search Travel',
          labelStyle:
          TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        // SpeedDialChild(
        //   child: Icon(Icons.laptop_chromebook, color: Colors.white),
        //   backgroundColor: AppColor.blackColor,
        //   onTap: () => print('Pressed Code'),
        //   label: 'Code',
        //   labelStyle:
        //   TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        //   labelBackgroundColor: Colors.black,
        // ),
      ],
    );
  }
}
