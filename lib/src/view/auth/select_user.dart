import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber_app/src/model/user_model.dart';
import 'package:uber_app/src/share/passenger_bottom_navigation_bar.dart';
import 'package:uber_app/src/style/app_color.dart';
import 'package:uber_app/src/view/Driver/driver_car_file.dart';
import 'package:uber_app/src/view/Passenger/passenger_buttom_navigator.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({Key? key}) : super(key: key);

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  final auth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                UserModel userModel = UserModel(
                  userName: auth!.displayName,
                  email: auth!.email,
                  phoneNumber: auth!.phoneNumber,
                  payment: "0",
                  profileImage: auth!.photoURL,
                  type: "Driver",
                  stats: true,
                  dateTime: DateTime.now(),
                  userId: auth!.uid,
                );
                FirebaseFirestore
                    .instance
                    .collection("Driver")
                    .doc(auth!.uid)
                    .set(userModel.toJson()).then((value){
                  FirebaseFirestore
                      .instance
                      .collection("users")
                      .doc(auth!.uid)
                      .update({
                    "type" : "Driver",
                  }).then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DriverCarFile()));
                  });
                });
              },
              child: Container(
                width: width * 1,
                height: height * 0.2,
                decoration: BoxDecoration(
                  color: AppColor.blackColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Driver",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                        color: AppColor.whiteColor
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            InkWell(
              onTap: (){
                UserModel userModel = UserModel(
                  userName: auth!.displayName,
                  email: auth!.email,
                  phoneNumber: auth!.phoneNumber,
                  payment: "0",
                  profileImage: auth!.photoURL,
                  type: "Driver",
                  stats: true,
                  dateTime: DateTime.now(),
                  userId: auth!.uid,
                );
                FirebaseFirestore
                    .instance
                    .collection("Passenger")
                    .doc(auth!.uid)
                    .set(userModel.toJson())
                    .then((value){
                  FirebaseFirestore
                      .instance
                      .collection("users")
                      .doc(auth!.uid)
                      .update({
                    "type" : "Passenger",
                  }).then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PassengerNavigator()));
                  });
                });
              },
              child: Container(
                width: width * 1,
                height: height * 0.2,
                decoration: BoxDecoration(
                  color: AppColor.blackColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Passenger",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColor.whiteColor
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
