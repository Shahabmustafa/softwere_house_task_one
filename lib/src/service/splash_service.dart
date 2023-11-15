import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_app/src/view/Driver/driver_buttom_navigator.dart';
import 'package:uber_app/src/view/auth/login_screen.dart';

class SplashService{

  final auth = FirebaseAuth.instance.currentUser;

  isSplash(BuildContext context){
    if(auth != null){
      Timer(Duration(seconds: 3),(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DriverButtomNavigator()));
      });
    }else{
      Timer(Duration(seconds: 3),(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    }
  }
}