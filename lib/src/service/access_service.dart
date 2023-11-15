import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_app/src/model/user_model.dart';
import 'package:uber_app/src/view/Driver/driver_buttom_navigator.dart';
import 'package:uber_app/src/view/Passenger/passenger_buttom_navigator.dart';
import 'package:uber_app/src/view/auth/login_screen.dart';

class AccessService with ChangeNotifier{
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;
  void checkCurrentUserRole(BuildContext context)async{
    final user = await firestore
        .collection("users")
        .doc(auth!.uid)
        .get();
    if(user["type"] == "Driver"){
      Timer(Duration(seconds: 3),(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DriverButtomNavigator()));
      });
    }else if(user["type"] == "Passenger"){
      Timer(Duration(seconds: 3),(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PassengerNavigator()));
      });
    }else if(user["type"] != "Passenger" && user["type"] != "Driver"){
      Timer(Duration(seconds: 3),(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    }
  }
}