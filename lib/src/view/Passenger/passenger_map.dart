import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uber_app/src/service/passenger_service.dart';
import 'package:uber_app/src/style/app_color.dart';


class PassengerMap extends StatefulWidget {
  const PassengerMap({Key? key}) : super(key: key);

  @override
  State<PassengerMap> createState() => _PassengerMapState();
}

class _PassengerMapState extends State<PassengerMap> {
  static final auth = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance.collection("Passenger").doc(auth);
  LocationData? currentLocation;
  Completer<GoogleMapController> _controller = Completer();
  PassengerService service = PassengerService();

  void getLocation()async{
    Location location = Location();
    location.getLocation().then((location){
      currentLocation = location;
      double? latitude = location.latitude;
      double? longitude = location.longitude;
      firestore.update({
        "latitude" : latitude,
        "longitude" : longitude,
      });
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



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              position: currentLocation == null ? LatLng(37.7749, -122.4194) : LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                title: "My Current Location",
              ),
            ),
          },
          zoomControlsEnabled: false,
        ),
        floatingActionButton: buildSpeedDial(context),
      ),
    );
  }
  SpeedDial buildSpeedDial(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
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
          onTap: (){
            getLocation();
          },
          label: 'Current Location',
          labelStyle:
          TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: Icon(Icons.search, color: Colors.white),
          backgroundColor: AppColor.blackColor,
          onTap: (){
            showModalBottomSheet(
                context: context,
                builder: (context){
                  return StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Driver").snapshots(),
                      builder: (context,snapshot){
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,index){
                              var data = snapshot.data!.docs[index];
                              return Column(
                                children: [
                                  ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        imageUrl: data["profileImage"] != null ?
                                        "https://i.pinimg.com/474x/a8/0e/36/a80e3690318c08114011145fdcfa3ddb.jpg" : data["profileImage"],
                                        height: 50,
                                        width: 50,
                                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                                            CircularProgressIndicator(value: downloadProgress.progress),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),
                                    title: Text(data["userName"]),
                                    subtitle: Text(data["phoneNumber"]),
                                    trailing: InkWell(
                                      onTap: (){
                                        FirebaseFirestore
                                            .instance
                                            .collection("Driver")
                                            .doc(data['userId'])
                                            .collection("travel")
                                            .doc(auth)
                                            .set({});
                                      },
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }else{
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                  );
                }
            );
          },
          label: 'Search Car',
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
