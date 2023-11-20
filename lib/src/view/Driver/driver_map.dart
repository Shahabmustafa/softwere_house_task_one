import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverMap extends StatefulWidget {
  const DriverMap({Key? key}) : super(key: key);

  @override
  State<DriverMap> createState() => _DriverMapState();
}

class _DriverMapState extends State<DriverMap> {
  static final auth = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance.collection("Driver").doc(auth);
  // LocationData? currentLocation;
  Completer<GoogleMapController> _controller = Completer();


  // void getLocation()async{
  //   Location location = Location();
  //   location.getLocation().then((location){
  //     currentLocation = location;
  //     double? latitude = location.latitude;
  //     double? longitude = location.longitude;
  //     firestore.update({
  //       "latitude" : latitude,
  //       "longitude" : longitude,
  //     });
  //   });
  //   GoogleMapController googleMapController = await _controller.future;
  //   location.onLocationChanged.listen((newloc){
  //     currentLocation = newloc;
  //     googleMapController.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //           zoom: 14,
  //           target: LatLng(newloc.latitude!, newloc.longitude!),
  //         ),
  //       ),
  //     );
  //     setState(() {
  //
  //     });
  //   });
  // }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), //// Initial map position
          zoom: 18.0,
        ),
        compassEnabled: true,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        markers: {
          Marker(
            markerId: MarkerId("Current Location"),
            // position: currentLocation == null ? LatLng(37.7749, -122.4194) : LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: "My Current Location",
            ),
          ),
        },
        zoomControlsEnabled: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // getLocation();
        },
        child: Icon(Icons.location_on),
      ),
    );
  }
}
