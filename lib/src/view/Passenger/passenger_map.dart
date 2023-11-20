import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class PassengerMap extends StatefulWidget {
  PassengerMap({Key? key,required this.latitude,required this.longitude,required this.profileImage}) : super(key: key);
  double latitude;
  double longitude;
  String profileImage;
  @override
  State<PassengerMap> createState() => _PassengerMapState();
}

class _PassengerMapState extends State<PassengerMap> {

  Completer<GoogleMapController> _controller = Completer();
  String googleAPiKey = "AIzaSyBwuUjRz1WHEH4-WIRidK8QUKJNSqQgDUU";
  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction;
  String mapTheme = "";
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  void getLocation()async{
    Location location = Location();
    location.getLocation().then((location){
      currentLocation = location;
    });
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((newloc){
      currentLocation = newloc;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 14,
            target: LatLng(newloc.latitude!, newloc.longitude!),
          ),
        ),
      );
      setState(() {

      });
    });
  }

  getDirections() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(widget.latitude,widget.longitude),
      PointLatLng(currentLocation!.latitude!,currentLocation!.longitude!),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context).loadString("assets/maptheme/silver.json").then((value){
      mapTheme = value;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude,widget.longitude),
          zoom: 18,
        ),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
          controller.setMapStyle(mapTheme);
        },
        markers: {
          Marker(
              markerId: MarkerId("driver"),
              position: LatLng(widget.latitude, widget.longitude),
              icon: BitmapDescriptor.defaultMarker,
              // infoWindow: InfoWindow(
              //   title: widget.departmentName,
              // ),
              onTap: (){
                setState(() {

                });
              }
          ),
          Marker(
            markerId: MarkerId("Current Location"),
            position: currentLocation == null ? LatLng(widget.latitude,widget.longitude) : LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: "My Current Location",
            ),
          ),
        },
        polylines: {
          Polyline(
              polylineId: PolylineId("routes"),
              points: polylineCoordinates,
              width: 3,
              color: Colors.red,
              jointType: JointType.bevel
          )
        },
        zoomGesturesEnabled: true,
        mapType: MapType.satellite,
        compassEnabled: true,
        zoomControlsEnabled: false,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: (){
              // getDirections();
            },
            child: Icon(Icons.directions),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: (){
              getLocation();
            },
            child: Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}