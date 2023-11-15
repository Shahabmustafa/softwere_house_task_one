import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_app/src/view/Driver/driver_buttom_navigator.dart';
import 'package:uber_app/src/view/Passenger/passenger_buttom_navigator.dart';
import 'package:uber_app/src/view/auth/login_screen.dart';

class SplashService{

  final auth = FirebaseAuth.instance.currentUser;
  final firebase = FirebaseFirestore.instance;

  isSplash(BuildContext context){
    if(auth != null){
      Timer(Duration(seconds: 3),(){
        firebase.collection("users")
            .doc(auth!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot){
              if(documentSnapshot.exists){
                if(documentSnapshot.get("type") == "Driver"){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DriverButtomNavigator()));
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PassengerNavigator()));
                }
              }else{
                print('Document does not exist on the database');
              }
        });
      });
    }else{
      Timer(Duration(seconds: 3),(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    }
  }
}